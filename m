Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD1E4C7850
	for <lists+linux-spi@lfdr.de>; Mon, 28 Feb 2022 19:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiB1SuA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Feb 2022 13:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiB1St7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Feb 2022 13:49:59 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5D329C86;
        Mon, 28 Feb 2022 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646074159; x=1677610159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jGNtYOYp/OrcQLCV4U/MBjkrMD4iTbDpW9b9kMxP6Io=;
  b=LRSx1EVuSFRIbtEZVpUkmG7vOW1033+9HXERGTRb3QfvIZtvwCp3DSC6
   Nc1e2QOPBLfFMCKAQU14zdchvCik8ZzTweS9OXW09X3llikh28Kjt8yrY
   br7b19bzXBLBJWJdkH6ru973UYg/nx6kCdpDrYxE3wTZ2eHiM97gMm+6s
   JC53Io1rJa3n6RxuxgJ9V/QE5EJ9hJdrIcJr+D3kHhaCTu3Es5qIGXEO/
   Y43hVTFUK/QFrYogFD+W9mwME8MZjCLplOf9SY14sa5u/SDOneMOLKSIL
   HPiEEzfJY0tMUXc3odiZnKUM08d62iK6RMwX9AbkVIfL3Ce62chwGXd1d
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316172792"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="316172792"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 10:49:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="708752385"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 10:49:17 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOl5A-0007hS-Cv; Mon, 28 Feb 2022 18:49:16 +0000
Date:   Tue, 1 Mar 2022 02:48:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     kbuild-all@lists.01.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Message-ID: <202203010212.oQMKRiPl-lkp@intel.com>
References: <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Christophe,

I love your patch! Yet something to improve:

[auto build test ERROR on v5.17-rc6]
[cannot apply to broonie-spi/for-next next-20220228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/Add-support-for-components-requiring-trailing-clock-after-transfer/20220228-231740
base:    7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220301/202203010212.oQMKRiPl-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7eb07c4d26401389204fcc6cf685c18c89b64ef8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Christophe-Leroy/Add-support-for-components-requiring-trailing-clock-after-transfer/20220228-231740
        git checkout 7eb07c4d26401389204fcc6cf685c18c89b64ef8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/spi/spi-fsl-spi.c: In function 'fsl_spi_do_one_msg':
>> drivers/spi/spi-fsl-spi.c:435:35: error: 'empty_zero_page' undeclared (first use in this function)
     435 |                         .tx_buf = empty_zero_page,
         |                                   ^~~~~~~~~~~~~~~
   drivers/spi/spi-fsl-spi.c:435:35: note: each undeclared identifier is reported only once for each function it appears in


vim +/empty_zero_page +435 drivers/spi/spi-fsl-spi.c

   356	
   357	static int fsl_spi_do_one_msg(struct spi_master *master,
   358				      struct spi_message *m)
   359	{
   360		struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
   361		struct spi_device *spi = m->spi;
   362		struct spi_transfer *t, *first;
   363		unsigned int cs_change;
   364		const int nsecs = 50;
   365		int status, last_bpw;
   366	
   367		/*
   368		 * In CPU mode, optimize large byte transfers to use larger
   369		 * bits_per_word values to reduce number of interrupts taken.
   370		 */
   371		if (!(mpc8xxx_spi->flags & SPI_CPM_MODE)) {
   372			list_for_each_entry(t, &m->transfers, transfer_list) {
   373				if (t->len < 256 || t->bits_per_word != 8)
   374					continue;
   375				if ((t->len & 3) == 0)
   376					t->bits_per_word = 32;
   377				else if ((t->len & 1) == 0)
   378					t->bits_per_word = 16;
   379			}
   380		}
   381	
   382		/* Don't allow changes if CS is active */
   383		cs_change = 1;
   384		list_for_each_entry(t, &m->transfers, transfer_list) {
   385			if (cs_change)
   386				first = t;
   387			cs_change = t->cs_change;
   388			if (first->speed_hz != t->speed_hz) {
   389				dev_err(&spi->dev,
   390					"speed_hz cannot change while CS is active\n");
   391				return -EINVAL;
   392			}
   393		}
   394	
   395		last_bpw = -1;
   396		cs_change = 1;
   397		status = -EINVAL;
   398		list_for_each_entry(t, &m->transfers, transfer_list) {
   399			if (cs_change || last_bpw != t->bits_per_word)
   400				status = fsl_spi_setup_transfer(spi, t);
   401			if (status < 0)
   402				break;
   403			last_bpw = t->bits_per_word;
   404	
   405			if (cs_change) {
   406				fsl_spi_chipselect(spi, BITBANG_CS_ACTIVE);
   407				ndelay(nsecs);
   408			}
   409			cs_change = t->cs_change;
   410			if (t->len)
   411				status = fsl_spi_bufs(spi, t, m->is_dma_mapped);
   412			if (status) {
   413				status = -EMSGSIZE;
   414				break;
   415			}
   416			m->actual_length += t->len;
   417	
   418			spi_transfer_delay_exec(t);
   419	
   420			if (cs_change) {
   421				ndelay(nsecs);
   422				fsl_spi_chipselect(spi, BITBANG_CS_INACTIVE);
   423				ndelay(nsecs);
   424			}
   425		}
   426	
   427		if (status || !cs_change) {
   428			ndelay(nsecs);
   429			fsl_spi_chipselect(spi, BITBANG_CS_INACTIVE);
   430		}
   431	
   432		if (!status && spi->trailing_bits) {
   433			struct spi_transfer t = {
   434				.len = 1,
 > 435				.tx_buf = empty_zero_page,
   436			};
   437	
   438			if (spi->trailing_bits < 4)
   439				t.bits_per_word = 4;
   440			else if (spi->trailing_bits > 8)
   441				t.bits_per_word = 16;
   442			else
   443				t.bits_per_word = spi->trailing_bits;
   444	
   445			status = fsl_spi_setup_transfer(spi, &t);
   446			if (!status)
   447				status = fsl_spi_bufs(spi, &t, 0);
   448		}
   449		m->status = status;
   450	
   451		fsl_spi_setup_transfer(spi, NULL);
   452		spi_finalize_current_message(master);
   453		return 0;
   454	}
   455	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
