project(
    'shim',
    'cpp',
    version: '1.0',
    default_options: ['cpp_std=c++20'],
)

src = ['shim.cpp']

obj_dir = meson.project_build_root() / 'obj'
bin_dir = meson.project_build_root() / 'bin'
archive_dir = meson.project_build_root() / 'archive'

executable(
    'shim',
    src,
    install: false,
    build_by_default: true,
)