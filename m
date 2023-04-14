Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7F26E1D81
	for <lists+linux-spi@lfdr.de>; Fri, 14 Apr 2023 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDNHwb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Apr 2023 03:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNHwa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Apr 2023 03:52:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5AC55BD;
        Fri, 14 Apr 2023 00:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681458747; x=1712994747;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=apPnk8MSDAWiqnUc2dL0KMnoOM44EeOt0KpzA494jLE=;
  b=fZoXKCpr0eseIoH7P39HCLz6ymEU03kpJyDHljuiOEy7OwZSiorQ/a3W
   CTkoToy7Ljyh5qWHlZv62dPma15EsqCQ5yrplyOrSI40YK0kYkbouMwom
   nW/JQGjOWQNmcTNzFAIsuyvMtiJrwSjx8o/buI1SwPEQItGOLLrtIlM9F
   49gS/FfM0syjAJEnCkaIlNuw+RzdSd8AyWrGgi9wBiA5hRotcqOmDVtHH
   NzUpw6/2Q8rAlxvU0WiXeEUQzx/RfTSfxgfKami2K9OxxXjmM9l8rq3fZ
   fB4Um0NCixO6+r1GbC9wPvh8451iMnBWKaKxPgsZOxMT2+/OEtPfnYQK8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="333177183"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="333177183"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 00:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="754357413"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="754357413"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2023 00:52:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnEEH-000ZLT-0x;
        Fri, 14 Apr 2023 07:52:21 +0000
Date:   Fri, 14 Apr 2023 15:52:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-wireless@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 e3342532ecd39bbd9c2ab5b9001cec1589bc37e9
Message-ID: <6439062a.+h0V1xopv/DQCX6A%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: e3342532ecd39bbd9c2ab5b9001cec1589bc37e9  Add linux-next specific files for 20230413

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303161521.jbGbaFjJ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304061839.hi01VPl1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304102354.Q4VOXGTE-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304140706.aOBNhUj2-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304140707.CoH337Ux-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304140732.NZcq7RdC-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/bluetooth/hci_qca.c:1894:37: warning: unused variable 'qca_soc_data_wcn6855' [-Wunused-const-variable]
drivers/clk/clk-sp7021.c:316:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:351:13: warning: variable 'bw_needed' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:352:25: warning: variable 'link' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h:62: warning: wrong kernel-doc identifier on line:
drivers/gpu/drm/i915/i915_pmu.h:41: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/i915/i915_request.h:176: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/i915/i915_vma.h:145: warning: expecting prototype for i915_vma_offset(). Prototype was for i915_vma_size() instead
drivers/net/wireless/legacy/ray_cs.c:628:17: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:240: undefined reference to `__floatundidf'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
kismet: WARNING: unmet direct dependencies detected for RESET_STARFIVE_JH7110 when selected by CLK_STARFIVE_JH7110_SYS
loongarch64-linux-ld: drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:240: undefined reference to `__ltdf2'
loongarch64-linux-ld: drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:242: undefined reference to `__gedf2'
phy-mtk-hdmi-mt8195.c:(.text+0x228): undefined reference to `__floatundidf'
phy-mtk-hdmi-mt8195.c:(.text+0x23c): undefined reference to `__ltdf2'
phy-mtk-hdmi-mt8195.c:(.text+0x264): undefined reference to `__gedf2'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/acpi/property.c:985 acpi_data_prop_read_single() error: potentially dereferencing uninitialized 'obj'.
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:240 mtk_hdmi_pll_calc() warn: impossible condition '(tmds_clk < 1.483500e+02 * 1000000) => (0.000000e+00-1.844674e+19 < -1.786711e-113)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:242 mtk_hdmi_pll_calc() warn: always true condition '(tmds_clk >= 1.483500e+02 * 1000000) => (0-u64max >= -1.786711e-113)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:242 mtk_hdmi_pll_calc() warn: impossible condition '(tmds_clk < 2.967000e+02 * 1000000) => (0.000000e+00-1.844674e+19 < -4.419080e+60)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:244 mtk_hdmi_pll_calc() warn: always true condition '(tmds_clk >= 2.967000e+02 * 1000000) => (0-u64max >= -4.419080e+60)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:331 mtk_hdmi_pll_drv_setting() warn: always true condition '(pixel_clk >= 7.417500e+01 * 1000000) => (0-u32max >= -7.223985e-287)'
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:336 mtk_hdmi_pll_drv_setting() warn: impossible condition '(pixel_clk < 7.417500e+01 * 1000000) => (0.000000e+00-4.294967e+09 < -7.223985e-287)'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-net-wireless-legacy-ray_cs.c:warning:strncpy-specified-bound-equals-destination-size
|-- alpha-randconfig-r021-20230414
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- csky-allnoconfig
|   `-- kismet:WARNING:unmet-direct-dependencies-detected-for-RESET_STARFIVE_JH7110-when-selected-by-CLK_STARFIVE_JH7110_SYS
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- i386-randconfig-m021
|   `-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentially-dereferencing-uninitialized-obj-.
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-net-wireless-legacy-ray_cs.c:warning:strncpy-specified-bound-equals-destination-size
|-- ia64-buildonly-randconfig-r005-20230409
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- loongarch-randconfig-r016-20230410
|   |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:undefined-reference-to-__floatundidf
|   |-- loongarch64-linux-ld:drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:undefined-reference-to-__gedf2
|   `-- loongarch64-linux-ld:drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:undefined-reference-to-__ltdf2
|-- loongarch-randconfig-r034-20230410
|   |-- phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__floatundidf
|   |-- phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__gedf2
|   `-- phy-mtk-hdmi-mt8195.c:(.text):undefined-reference-to-__ltdf2
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- mips-randconfig-r034-20230409
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- openrisc-randconfig-r002-20230409
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- parisc-buildonly-randconfig-r003-20230410
|   `-- drivers-net-wireless-legacy-ray_cs.c:warning:strncpy-specified-bound-equals-destination-size
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- powerpc-randconfig-s053-20230413
|   `-- drivers-spi-spi-fsl-cpm.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-unsigned-short-usertype-got-restricted-__le16
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-net-wireless-legacy-ray_cs.c:warning:strncpy-specified-bound-equals-destination-size
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
`-- xtensa-randconfig-m041-20230411
    |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-warn:always-true-condition-(tmds_clk-.483500e-)-(-u64max-.786711e-)
    |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-warn:always-true-condition-(tmds_clk-.967000e-)-(-u64max-.419080e-)
    |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-warn:impossible-condition-(tmds_clk-.483500e-)-(.000000e-.844674e-.786711e-)
    |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_calc()-warn:impossible-condition-(tmds_clk-.967000e-)-(.000000e-.844674e-.419080e-)
    |-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_drv_setting()-warn:always-true-condition-(pixel_clk-.417500e-)-(-u32max-.223985e-)
    `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c-mtk_hdmi_pll_drv_setting()-warn:impossible-condition-(pixel_clk-.417500e-)-(.000000e-.294967e-.223985e-)
clang_recent_errors
|-- arm-randconfig-r046-20230409
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- arm-randconfig-r046-20230412
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- arm64-randconfig-r003-20230409
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- arm64-randconfig-r015-20230413
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- hexagon-allyesconfig
|   `-- drivers-clk-clk-sp7021.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((_m)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
|-- riscv-randconfig-r035-20230410
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- x86_64-randconfig-a003-20230410
|   `-- drivers-bluetooth-hci_qca.c:warning:unused-variable-qca_soc_data_wcn6855
`-- x86_64-randconfig-a005-20230410
    |-- drivers-gpu-drm-i915-gt-uc-guc_capture_fwif.h:warning:wrong-kernel-doc-identifier-on-line:
    |-- drivers-gpu-drm-i915-i915_pmu.h:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
    |-- drivers-gpu-drm-i915-i915_request.h:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
    `-- drivers-gpu-drm-i915-i915_vma.h:warning:expecting-prototype-for-i915_vma_offset().-Prototype-was-for-i915_vma_size()-instead

elapsed time: 723m

configs tested: 194
configs skipped: 20

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230410   gcc  
alpha                randconfig-r003-20230412   gcc  
alpha                randconfig-r013-20230410   gcc  
alpha                randconfig-r021-20230414   gcc  
alpha                randconfig-r023-20230414   gcc  
alpha                randconfig-r026-20230414   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230409   gcc  
arc          buildonly-randconfig-r006-20230412   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230410   gcc  
arc                  randconfig-r025-20230414   gcc  
arc                  randconfig-r031-20230410   gcc  
arc                  randconfig-r036-20230413   gcc  
arc                  randconfig-r043-20230412   gcc  
arc                  randconfig-r043-20230413   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                  randconfig-r002-20230412   gcc  
arm                  randconfig-r022-20230414   clang
arm                  randconfig-r046-20230412   clang
arm                  randconfig-r046-20230413   gcc  
arm                             rpc_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230412   clang
arm64        buildonly-randconfig-r006-20230413   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230409   clang
arm64                randconfig-r015-20230413   clang
csky                                defconfig   gcc  
csky                 randconfig-r015-20230409   gcc  
csky                 randconfig-r031-20230409   gcc  
csky                 randconfig-r034-20230414   gcc  
hexagon              randconfig-r003-20230413   clang
hexagon              randconfig-r033-20230414   clang
hexagon              randconfig-r041-20230412   clang
hexagon              randconfig-r041-20230413   clang
hexagon              randconfig-r045-20230412   clang
hexagon              randconfig-r045-20230413   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230410   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
i386                 randconfig-r006-20230410   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230410   gcc  
ia64         buildonly-randconfig-r002-20230409   gcc  
ia64         buildonly-randconfig-r005-20230409   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230409   gcc  
loongarch            randconfig-r032-20230414   gcc  
loongarch            randconfig-r034-20230410   gcc  
loongarch            randconfig-r035-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230409   gcc  
m68k                 randconfig-r016-20230409   gcc  
m68k                 randconfig-r021-20230410   gcc  
m68k                 randconfig-r024-20230409   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze   buildonly-randconfig-r004-20230410   gcc  
microblaze           randconfig-r023-20230410   gcc  
microblaze           randconfig-r024-20230414   gcc  
microblaze           randconfig-r036-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230409   gcc  
mips         buildonly-randconfig-r006-20230409   gcc  
mips                     cu1000-neo_defconfig   clang
mips                        omega2p_defconfig   clang
mips                 randconfig-r001-20230409   gcc  
mips                 randconfig-r001-20230410   gcc  
mips                 randconfig-r001-20230412   gcc  
mips                 randconfig-r005-20230412   gcc  
mips                 randconfig-r012-20230410   clang
mips                 randconfig-r014-20230413   gcc  
mips                 randconfig-r023-20230409   clang
mips                 randconfig-r032-20230413   clang
mips                 randconfig-r034-20230409   gcc  
nios2        buildonly-randconfig-r004-20230413   gcc  
nios2        buildonly-randconfig-r005-20230412   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230413   gcc  
nios2                randconfig-r011-20230409   gcc  
nios2                randconfig-r013-20230409   gcc  
nios2                randconfig-r015-20230410   gcc  
nios2                randconfig-r016-20230410   gcc  
nios2                randconfig-r034-20230413   gcc  
openrisc             randconfig-r002-20230409   gcc  
openrisc             randconfig-r006-20230412   gcc  
openrisc             randconfig-r024-20230410   gcc  
openrisc             randconfig-r036-20230414   gcc  
parisc       buildonly-randconfig-r003-20230410   gcc  
parisc                              defconfig   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc                      makalu_defconfig   gcc  
powerpc                mpc7448_hpc2_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r002-20230410   clang
powerpc              randconfig-r006-20230409   clang
powerpc              randconfig-r011-20230410   gcc  
powerpc              randconfig-r026-20230410   gcc  
powerpc              randconfig-r033-20230413   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230410   gcc  
riscv        buildonly-randconfig-r004-20230412   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230410   gcc  
riscv                randconfig-r035-20230410   clang
riscv                randconfig-r042-20230412   gcc  
riscv                randconfig-r042-20230413   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230413   clang
s390         buildonly-randconfig-r003-20230412   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230413   gcc  
s390                 randconfig-r035-20230414   clang
s390                 randconfig-r044-20230412   gcc  
s390                 randconfig-r044-20230413   clang
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                   randconfig-r006-20230413   gcc  
sh                   randconfig-r011-20230413   gcc  
sh                   randconfig-r035-20230413   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc        buildonly-randconfig-r003-20230413   gcc  
sparc        buildonly-randconfig-r005-20230413   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64              randconfig-r016-20230413   gcc  
sparc64              randconfig-r022-20230410   gcc  
sparc64              randconfig-r032-20230409   gcc  
sparc64              randconfig-r033-20230409   gcc  
sparc64              randconfig-r036-20230409   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230409   gcc  
xtensa               randconfig-r031-20230413   gcc  
xtensa               randconfig-r031-20230414   gcc  
xtensa               randconfig-r033-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
