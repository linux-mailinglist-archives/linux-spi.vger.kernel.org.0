Return-Path: <linux-spi+bounces-10035-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A5DB58E2B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 07:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D0748441A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 05:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469E52DCF62;
	Tue, 16 Sep 2025 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCeTEXEM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FDFAD2C;
	Tue, 16 Sep 2025 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758002162; cv=none; b=MqyWbDDF9NH4k5NiuGRNPonkLT+XXVEkV08ZosLUascK+DCjptfb1ivja3lj6FaTiQgG5dAOB69kdFpZ07qeSQzjzmWPIDxKlsMb+629YdcyeSG65fEjCSE9DlGWNsDy7BViGPCUTRx+9vLewAsiPbgh03FcIRW10JEWFW+vH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758002162; c=relaxed/simple;
	bh=wu6bU/KO03onjSI0MOAjOnCKmp6Vw1VX8ZqN526KOMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcxucudilGvswnLx20KUr7J43tAamhoer5kQFQAKVqNLGVnaelx/QbVrNCIRYnyoZGa3RQmQluqy1othrT6c91nKUnuK9UtfFc4LRHM8bX4oskNoDhdYagz7jw6MA+s8OwJxUmLo7n2ai+jLcqIWh4mbQo7jUZycV3VNGmsqrMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCeTEXEM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758002161; x=1789538161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wu6bU/KO03onjSI0MOAjOnCKmp6Vw1VX8ZqN526KOMM=;
  b=BCeTEXEMy9JHggfpPd9KykrmT/YH3VrojcL/okjXJPVMKZeWpZTe8RWa
   VGG5IKI4bvdN3RMghaM6zAHTaMN4RT8J0sEBTRyfq0Zy2QU8giZMtes0B
   LLCkfjM5yAQffzyZZp4DfaBm6ReKUOt3tln5oDOV3zJTPyp7jFT41fy3E
   11W//Ei79aOxxm4ecR8wBEnLIzEjPkHMBYvpB1WCfujNfJBk2wSEbEcd/
   lah0cleRH1W9Z1IvSWFtRAzLf0rhCAGMq0l1En4+qzEBzoGYUlcHaSqzk
   wu5y57xp2qylTqZVWE3MIHRkXYRYB7RaclgiMrqM44zY/E9qDxU+GpLg/
   Q==;
X-CSE-ConnectionGUID: 5fDug2QAQhOEjf//dGBC2w==
X-CSE-MsgGUID: dPMjIB2NRV6BJKNzJWszSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="70520748"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="70520748"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 22:55:54 -0700
X-CSE-ConnectionGUID: 4cZH8160TbCLJ4fD4SAk7g==
X-CSE-MsgGUID: v3Gp01YyR5GU4xDEiNleWw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 5b01dd97f97c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2025 22:55:51 -0700
Received: from kbuild by 5b01dd97f97c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyOfM-00012J-39;
	Tue, 16 Sep 2025 05:55:48 +0000
Date: Tue, 16 Sep 2025 13:55:39 +0800
From: kernel test robot <lkp@intel.com>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Axiado Reviewers <linux-maintainer@axiado.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vladimir Moravcevic <vmoravcevic@axiado.com>
Subject: Re: [PATCH 2/3] spi: axiado: Add driver for Axiado SPI DB controller
Message-ID: <202509161348.JWCcODvq-lkp@intel.com>
References: <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-2-814a1fa2a83e@axiado.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-2-814a1fa2a83e@axiado.com>

Hi Vladimir,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e6b9dce0aeeb91dfc0974ab87f02454e24566182]

url:    https://github.com/intel-lab-lkp/linux/commits/Vladimir-Moravcevic/dt-bindings-spi-axiado-ax3000-spi-Add-binding-for-Axiado-SPI-DB-controller/20250915-211453
base:   e6b9dce0aeeb91dfc0974ab87f02454e24566182
patch link:    https://lore.kernel.org/r/20250915-axiado-ax3000-soc-spi-db-controller-driver-v1-2-814a1fa2a83e%40axiado.com
patch subject: [PATCH 2/3] spi: axiado: Add driver for Axiado SPI DB controller
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250916/202509161348.JWCcODvq-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 65ad21d730d25789454d18e811f8ff5db79cb5d4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509161348.JWCcODvq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509161348.JWCcODvq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:3:
   In file included from include/linux/compiler_types.h:171:
   include/linux/compiler-clang.h:28:9: warning: '__SANITIZE_ADDRESS__' macro redefined [-Wmacro-redefined]
      28 | #define __SANITIZE_ADDRESS__
         |         ^
   <built-in>:371:9: note: previous definition is here
     371 | #define __SANITIZE_ADDRESS__ 1
         |         ^
>> drivers/spi/spi-axiado.c:480:6: warning: variable 'total_tx_bytes_for_op' set but not used [-Wunused-but-set-variable]
     480 |         int total_tx_bytes_for_op, bytes_to_discard_from_rx;
         |             ^
   2 warnings generated.


vim +/total_tx_bytes_for_op +480 drivers/spi/spi-axiado.c

   470	
   471	static int ax_spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
   472	{
   473		struct spi_device *spi = mem->spi;
   474		struct ax_spi *xspi = spi_controller_get_devdata(spi->controller);
   475		u32 reg_val;
   476		int ret = 0;
   477		u8 cmd_buf[AX_SPI_COMMAND_BUFFER_SIZE];
   478		int cmd_len = 0;
   479		int i = 0, timeout = AX_SPI_TRX_FIFO_TIMEOUT;
 > 480		int total_tx_bytes_for_op, bytes_to_discard_from_rx;
   481		u8 *rx_buf_ptr = (u8 *)op->data.buf.in;
   482		u8 *tx_buf_ptr = (u8 *)op->data.buf.out;
   483		u32 rx_count_reg = 0;
   484	
   485		dev_dbg(&spi->dev,
   486			"%s: cmd:%02x mode:%d.%d.%d.%d addr:%llx len:%d\n",
   487			__func__, op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
   488			op->dummy.buswidth, op->data.buswidth, op->addr.val,
   489			op->data.nbytes);
   490	
   491		/* Validate operation parameters: Only 1-bit bus width supported */
   492		if (op->cmd.buswidth != 1 ||
   493		    (op->addr.nbytes && op->addr.buswidth != 0 &&
   494		    op->addr.buswidth != 1) ||
   495		    (op->dummy.nbytes && op->dummy.buswidth != 0 &&
   496		    op->dummy.buswidth != 1) ||
   497		    (op->data.nbytes && op->data.buswidth != 1)) {
   498			dev_err(&spi->dev, "Unsupported bus width, only 1-bit bus width supported\n");
   499			return -EOPNOTSUPP;
   500		}
   501	
   502		/* Initialize controller hardware */
   503		ax_spi_init_hw(xspi);
   504	
   505		/* Assert chip select (pull low) */
   506		ax_spi_chipselect(spi, false);
   507	
   508		/* Build command phase: Copy opcode to cmd_buf */
   509		if (op->cmd.nbytes == 2) {
   510			cmd_buf[cmd_len++] = (op->cmd.opcode >> 8) & 0xFF;
   511			cmd_buf[cmd_len++] = op->cmd.opcode & 0xFF;
   512		} else {
   513			cmd_buf[cmd_len++] = op->cmd.opcode;
   514		}
   515	
   516		/* Put address bytes to cmd_buf */
   517		if (op->addr.nbytes) {
   518			for (i = op->addr.nbytes - 1; i >= 0; i--) {
   519				cmd_buf[cmd_len] = (op->addr.val >> (i * 8)) & 0xFF;
   520				cmd_len++;
   521			}
   522		}
   523	
   524		/* Configure controller for desired operation mode (write/read) */
   525		reg_val = ax_spi_read(xspi, AX_SPI_CR2);
   526		reg_val |= AX_SPI_CR2_SWD | AX_SPI_CR2_SRI | AX_SPI_CR2_SRD;
   527		ax_spi_write(xspi, AX_SPI_CR2, reg_val);
   528	
   529		/* Calculate total bytes to clock out and fill TX FIFO */
   530		total_tx_bytes_for_op = cmd_len;
   531		if (op->data.dir == SPI_MEM_DATA_IN) {
   532			total_tx_bytes_for_op += op->dummy.nbytes;
   533			total_tx_bytes_for_op += op->data.nbytes;
   534		} else {
   535			total_tx_bytes_for_op += op->data.nbytes;
   536		}
   537	
   538		/* Write command and address bytes to TX_FIFO */
   539		for (i = 0; i < cmd_len; i++)
   540			ax_spi_write_b(xspi, AX_SPI_TXFIFO, cmd_buf[i]);
   541	
   542		/* Add dummy bytes (for clock generation) or actual data bytes to TX_FIFO */
   543		if (op->data.dir == SPI_MEM_DATA_IN) {
   544			for (i = 0; i < op->dummy.nbytes; i++)
   545				ax_spi_write_b(xspi, AX_SPI_TXFIFO, 0x00);
   546			for (i = 0; i < op->data.nbytes; i++)
   547				ax_spi_write_b(xspi, AX_SPI_TXFIFO, 0x00);
   548		} else {
   549			for (i = 0; i < op->data.nbytes; i++)
   550				ax_spi_write_b(xspi, AX_SPI_TXFIFO, tx_buf_ptr[i]);
   551		}
   552	
   553		/* Start the SPI transmission */
   554		reg_val = ax_spi_read(xspi, AX_SPI_CR2);
   555		reg_val |= AX_SPI_CR2_HTE;
   556		ax_spi_write(xspi, AX_SPI_CR2, reg_val);
   557	
   558		/* Wait for TX FIFO to become empty */
   559		while (timeout-- > 0) {
   560			u32 tx_count_reg = ax_spi_read(xspi, AX_SPI_TX_FBCAR);
   561	
   562			if (tx_count_reg == 0) {
   563				udelay(1);
   564				break;
   565			}
   566			udelay(1);
   567		}
   568	
   569		/* Handle Data Reception (for read operations) */
   570		if (op->data.dir == SPI_MEM_DATA_IN) {
   571			/* Reset the internal RX byte buffer for this new operation.
   572			 * This ensures ax_spi_get_rx_byte starts fresh for each exec_op call.
   573			 */
   574			xspi->bytes_left_in_current_rx_word = 0;
   575			xspi->current_rx_fifo_word = 0;
   576	
   577			timeout = AX_SPI_TRX_FIFO_TIMEOUT;
   578			while (timeout-- > 0) {
   579				rx_count_reg = ax_spi_read(xspi, AX_SPI_RX_FBCAR);
   580				if (rx_count_reg >= op->data.nbytes)
   581					break;
   582				udelay(1); // Small delay to prevent aggressive busy-waiting
   583			}
   584	
   585			if (timeout < 0) {
   586				ret = -ETIMEDOUT;
   587				goto out_unlock;
   588			}
   589	
   590			/* Calculate how many bytes we need to discard from the RX FIFO.
   591			 * Since we set SRI, we only need to discard the address bytes and
   592			 * dummy bytes from the RX FIFO.
   593			 */
   594			bytes_to_discard_from_rx = op->addr.nbytes + op->dummy.nbytes;
   595			for (i = 0; i < bytes_to_discard_from_rx; i++)
   596				ax_spi_get_rx_byte(xspi);
   597	
   598			/* Read actual data bytes into op->data.buf.in */
   599			for (i = 0; i < op->data.nbytes; i++) {
   600				*rx_buf_ptr = ax_spi_get_rx_byte(xspi);
   601				rx_buf_ptr++;
   602			}
   603		} else if (op->data.dir == SPI_MEM_DATA_OUT) {
   604			timeout = AX_SPI_TRX_FIFO_TIMEOUT;
   605			while (timeout-- > 0) {
   606				u32 tx_fifo_level = ax_spi_read(xspi, AX_SPI_TX_FBCAR);
   607	
   608				if (tx_fifo_level == 0)
   609					break;
   610				udelay(1);
   611			}
   612			if (timeout < 0) {
   613				ret = -ETIMEDOUT;
   614				goto out_unlock;
   615			}
   616		}
   617	
   618	out_unlock:
   619		/* Deassert chip select (pull high) */
   620		ax_spi_chipselect(spi, true);
   621	
   622		return ret;
   623	}
   624	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

