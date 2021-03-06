module prob_params_module
    ! This module stores the runtime parameters that define the problem domain.
    ! These parameter are initialized in set_problem_params().

  use meth_params_module, only: UMX, UMZ
  use amrex_fort_module, only: rt => amrex_real
  use probdata_module, only: center ! for backwards compatibility

  implicit none

  ! boundary condition information
  integer, allocatable :: physbc_lo(:)
  integer, allocatable :: physbc_hi(:)
  integer, allocatable :: Interior, Inflow, Outflow, Symmetry, SlipWall, NoSlipWall

  ! geometry information
  integer,  allocatable, save :: coord_type
  real(rt), allocatable :: problo(:), probhi(:)

  ! dimension information
  integer, save, allocatable :: dim

  ! indices that we use for dimension agnostic routines
  ! to ensure we don't illegally access non-existent ghost cells
  ! the format is dg(1:dim) = 1, dg(dim+1:3) = 0
  integer, save, allocatable :: dg(:)

  ! grid information
  integer         , save              :: max_level
  real(rt)        , save, allocatable :: dx_level(:,:)
  integer         , save, allocatable :: domlo_level(:,:)
  integer         , save, allocatable :: domhi_level(:,:)
  integer         , save, allocatable :: ref_ratio(:,:)
  integer         , save, allocatable :: n_error_buf(:)
  integer         , save, allocatable :: blocking_factor(:)

#ifdef AMREX_USE_CUDA
  attributes(managed) :: physbc_lo, physbc_hi
  attributes(managed) :: Interior, Inflow, Outflow, Symmetry, Slipwall, NoSlipWall
  attributes(managed) :: dim
  attributes(managed) :: dg
  attributes(managed) :: coord_type
  attributes(managed) :: problo, probhi
  attributes(managed) :: domlo_level, domhi_level, dx_level
  attributes(managed) :: ref_ratio, n_error_buf, blocking_factor
#endif

  !$acc declare create(physbc_lo, physbc_hi)
  !$acc declare create(Interior, Inflow, Outflow, Symmetry, Slipwall, NoSlipWall)
  !$acc declare create(dim)
  !$acc declare create(dg)
  !$acc declare create(coord_type)
  !$acc declare create(problo, probhi)
  !$acc declare create(domlo_level, domhi_level, dx_level)
  !$acc declare create(ref_ratio, n_error_buf, blocking_factor)

end module prob_params_module
