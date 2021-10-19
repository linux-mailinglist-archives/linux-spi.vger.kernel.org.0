Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C5E43355B
	for <lists+linux-spi@lfdr.de>; Tue, 19 Oct 2021 14:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhJSMHZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Oct 2021 08:07:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:3082 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhJSMHX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 19 Oct 2021 08:07:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="314691143"
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="gz'50?scan'50,208,50";a="314691143"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 05:05:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="gz'50?scan'50,208,50";a="444464548"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Oct 2021 05:05:04 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mcnrb-000CN5-EA; Tue, 19 Oct 2021 12:05:03 +0000
Date:   Tue, 19 Oct 2021 20:04:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] spi: spi-geni-qcom: Add support for GPI dma
Message-ID: <202110192016.GME3lPjO-lkp@intel.com>
References: <20211019060135.1482666-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20211019060135.1482666-1-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Vinod,

I love your patch! Perhaps something to improve:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on v5.15-rc6 next-20211019]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Vinod-Koul/spi-spi-geni-qcom-Add-support-for-GPI-dma/20211019-140206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: i386-buildonly-randconfig-r005-20211019 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b37efed957ed0a0193d80020aefd55cb587dfc1f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4328916194e339d055a1d4c02170602b775ce334
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Vinod-Koul/spi-spi-geni-qcom-Add-support-for-GPI-dma/20211019-140206
        git checkout 4328916194e339d055a1d4c02170602b775ce334
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-geni-qcom.c:401:41: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
           peripheral.loopback_en = spi_slv->mode && SPI_LOOP;
                                                  ^  ~~~~~~~~
   drivers/spi/spi-geni-qcom.c:401:41: note: use '&' for a bitwise operation
           peripheral.loopback_en = spi_slv->mode && SPI_LOOP;
                                                  ^~
                                                  &
   drivers/spi/spi-geni-qcom.c:401:41: note: remove constant to silence this warning
           peripheral.loopback_en = spi_slv->mode && SPI_LOOP;
                                                 ~^~~~~~~~~~~
   drivers/spi/spi-geni-qcom.c:402:44: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
           peripheral.clock_pol_high = spi_slv->mode && SPI_CPOL;
                                                     ^  ~~~~~~~~
   drivers/spi/spi-geni-qcom.c:402:44: note: use '&' for a bitwise operation
           peripheral.clock_pol_high = spi_slv->mode && SPI_CPOL;
                                                     ^~
                                                     &
   drivers/spi/spi-geni-qcom.c:402:44: note: remove constant to silence this warning
           peripheral.clock_pol_high = spi_slv->mode && SPI_CPOL;
                                                    ~^~~~~~~~~~~
   2 warnings generated.


vim +401 drivers/spi/spi-geni-qcom.c

   365	
   366	static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas,
   367				  struct spi_device *spi_slv, struct spi_master *spi)
   368	{
   369		unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
   370		struct dma_slave_config config = {};
   371		struct gpi_spi_config peripheral = {};
   372		struct dma_async_tx_descriptor *tx_desc, *rx_desc;
   373		int ret;
   374	
   375		config.peripheral_config = &peripheral;
   376		config.peripheral_size = sizeof(peripheral);
   377		peripheral.set_config = true;
   378	
   379		if (xfer->bits_per_word != mas->cur_bits_per_word ||
   380		    xfer->speed_hz != mas->cur_speed_hz) {
   381			mas->cur_bits_per_word = xfer->bits_per_word;
   382			mas->cur_speed_hz = xfer->speed_hz;
   383		}
   384	
   385		if (xfer->tx_buf && xfer->rx_buf) {
   386			peripheral.cmd = SPI_DUPLEX;
   387		} else if (xfer->tx_buf) {
   388			peripheral.cmd = SPI_TX;
   389			peripheral.rx_len = 0;
   390		} else if (xfer->rx_buf) {
   391			peripheral.cmd = SPI_RX;
   392			if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
   393				peripheral.rx_len = ((xfer->len << 3) / mas->cur_bits_per_word);
   394			} else {
   395				int bytes_per_word = (mas->cur_bits_per_word / BITS_PER_BYTE) + 1;
   396	
   397				peripheral.rx_len = (xfer->len / bytes_per_word);
   398			}
   399		}
   400	
 > 401		peripheral.loopback_en = spi_slv->mode && SPI_LOOP;
   402		peripheral.clock_pol_high = spi_slv->mode && SPI_CPOL;
   403		peripheral.data_pol_high = spi_slv->mode && SPI_CPHA;
   404		peripheral.cs = spi_slv->chip_select;
   405		peripheral.pack_en = true;
   406		peripheral.word_len = xfer->bits_per_word - MIN_WORD_LEN;
   407	
   408		ret = get_spi_clk_cfg(mas->cur_speed_hz, mas,
   409				      &peripheral.clk_src, &peripheral.clk_div);
   410		if (ret) {
   411			dev_err(mas->dev, "Err in get_spi_clk_cfg() :%d\n", ret);
   412			return ret;
   413		}
   414	
   415		if (!xfer->cs_change) {
   416			if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
   417				peripheral.fragmentation = FRAGMENTATION;
   418		}
   419	
   420		if (peripheral.cmd & SPI_RX) {
   421			dmaengine_slave_config(mas->rx, &config);
   422			rx_desc = dmaengine_prep_slave_sg(mas->rx, xfer->rx_sg.sgl, xfer->rx_sg.nents,
   423							  DMA_DEV_TO_MEM, flags);
   424			if (!rx_desc) {
   425				dev_err(mas->dev, "Err setting up rx desc\n");
   426				return -EIO;
   427			}
   428		}
   429	
   430		/*
   431		 * Prepare the TX always, even for RX or tx_buf being null, we would
   432		 * need TX to be prepared per GSI spec
   433		 */
   434		dmaengine_slave_config(mas->tx, &config);
   435		tx_desc = dmaengine_prep_slave_sg(mas->tx, xfer->tx_sg.sgl, xfer->tx_sg.nents,
   436						  DMA_MEM_TO_DEV, flags);
   437		if (!tx_desc) {
   438			dev_err(mas->dev, "Err setting up tx desc\n");
   439			return -EIO;
   440		}
   441	
   442		tx_desc->callback_result = spi_gsi_callback_result;
   443		tx_desc->callback_param = spi;
   444	
   445		if (peripheral.cmd & SPI_RX)
   446			dmaengine_submit(rx_desc);
   447		dmaengine_submit(tx_desc);
   448	
   449		if (peripheral.cmd & SPI_RX)
   450			dma_async_issue_pending(mas->rx);
   451	
   452		dma_async_issue_pending(mas->tx);
   453		return 1;
   454	}
   455	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--cNdxnHkX5QqsyA0e
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICAymbmEAAy5jb25maWcAjFxJd9u4st73r9BJb/ouOpHHpN87XkAkKKFFEjRAavCGx7Hl
br/2kCvLfTv//lUBHACwqNwsfEJUYS5UfVUo6Oeffp6w98Pr8+3h8e726en75I/dy25/e9jd
Tx4en3b/O4nlJJflhMei/AjM6ePL+z+fHs++XE4uPp5cfJz+ur+7nCx3+5fd0yR6fXl4/OMd
qj++vvz080+RzBMxr6OoXnGlhczrkm/Kqw93T7cvf0z+3u3fgG9ycv5x+nE6+eWPx8P/fPoE
f58f9/vX/aenp7+f62/71//b3R0mX88+7x52979dfN7dT2+nJ7+d3X+ZTk+nt7uH+4uLu68X
Xz7fP9ydPPzrQ9vrvO/2auoMReg6Slk+v/reFeJnx3tyPoV/LY1prJCmq6znhzKaOY2HPUKZ
aSDu66cOn98ADC9ieZ2KfOkMry+sdclKEXm0BQyH6ayey1KOEmpZlUVV9vRSylTXuioKqcpa
8VSRdUUO3fIBKZd1oWQiUl4nec3K0q0tc12qKiql0n2pUNf1WipnWrNKpHEpMl6XbAYNaRiI
M76F4gyWLk8k/AEWjVVBpn6ezI2EPk3edof3b72UzZRc8rwGIdNZ4XSci7Lm+apmClZeZKK8
Ojvtx5oVOImSa+z750lTvuZKSTV5fJu8vB6wo27rZMTSdu8+fPDmUmuWlk7hgq14veQq52k9
vxHOmFzKDCinNCm9yRhN2dyM1ZBjhHOacKPL2J25M153+iHdjPoYA479GH1zc7y2PE4+J/bG
n1FTGPOEVWlpxMDZm7Z4IXWZs4xfffjl5fVlB9qj60uvGb0EeqtXooiIERRSi02dXVe8cs7M
mpXRog4KIyW1rjOeSbXFA8SihbsNleapmBFdsAoUcbCVTEH7hgBDA/lMHVXll5rzA0dx8vb+
9e3722H33J+fOc+5EpE5qXC4Z85gXZJeyDVNEfnvPCrxYDjDUzGQQNGsQcdonsd01WjhHg8s
iWXGRO6XaZFRTPVCcIVrsPWpCdMll6Inw3DyOOWuWnIHgQNUK4YzqDMZ86A1qSIeN3pJuOZD
F0xpjkx0uzGfVfNEm+3dvdxPXh+CLejtkIyWWlbQkRWaWDrdmF12WYxIf6cqr1gqYlbyOoUl
qKNtlBKbaVTvaiAxLdm0x1c8L4nlcoh1BjvA4t8rXRJ8mdR1VeBYApm1RyUqKjMOpY2Gby2E
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

--cNdxnHkX5QqsyA0e--
