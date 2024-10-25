Return-Path: <linux-spi+bounces-5466-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C76C09B093A
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CF41F2279B
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0243175D46;
	Fri, 25 Oct 2024 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIsa5Qyv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2C16FF44;
	Fri, 25 Oct 2024 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872559; cv=none; b=V/LawBlcSzd60EBSupA4KgVOSOTOjrZW6px94980y39nWbGl5RC/G2XFgV+E/TFKYdObh5/A1D8xPhJ1px+skDtQ0XiaZt9K6635TynMfugXfF/TfjOGYUaVeXUNuXwDuPzQn3PFKj5OGBxsiCmYL+6++nq9zlHdkMPj0rJyIvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872559; c=relaxed/simple;
	bh=bg7ld2Rvq1YDUxAKGt3jeDUJXtPakerYwHO9+3j/ZH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZ6D67pxCKGf+D9gg2bHN6k47R0LCpW+QhuXZAIS1fBcUvB0ORemU6crYwjAIlrpgfbEnmOvwFwTkR262356SUYl4Fj35FpWop7JLOUjBYwM+vkmk9pIRTzKJWeXDzRS9PXddAgocigqIMTO70YQhn0CeMVmD9Ab8rdAvfESyj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIsa5Qyv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729872558; x=1761408558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bg7ld2Rvq1YDUxAKGt3jeDUJXtPakerYwHO9+3j/ZH8=;
  b=AIsa5QyvA5FU0obTz52OOE07k81Cj3gvBUFFjqXbLhP4g1Y8tJIlQ7Np
   52rvrFkgWM6OJYWM7bKOyctQlNyqpfIU8iGZqClNIEMieJswwWVcdZcLX
   tq62ZZEeJHDKXhFQ+c4sX/fEaus8qvd89ErW1KXOhSTHqWYCAivpQd07U
   a46Rhocs+kl2C0lIaM0uGawFwRH6B7QE7Z0R6RTH30h0FgPfRDE4pYlXn
   trS873vtU5IOe6QOUfBEnEXkK4lLyouAnHeVZj8E7VPUh4id/TBHhRxGq
   9RfuEGRGfuvo+fuYSEY/aw/ZwLQncwgMPSmJtZJoBjyNVuDS5x37QuGEr
   Q==;
X-CSE-ConnectionGUID: LZjdXDshQU6wzH8fcDkULg==
X-CSE-MsgGUID: L82BmWEiQHOxY6L3nDsC7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29323456"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29323456"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 09:09:17 -0700
X-CSE-ConnectionGUID: yb5LgQFzSZ6QPHlWDkuyHw==
X-CSE-MsgGUID: ZS7B1GaAQr+cJ7qU9CNZ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="85541252"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Oct 2024 09:09:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4MsA-000YS2-0q;
	Fri, 25 Oct 2024 16:09:10 +0000
Date: Sat, 26 Oct 2024 00:08:35 +0800
From: kernel test robot <lkp@intel.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, quic_srichara@quicinc.com,
	quic_varada@quicinc.com, quic_mdalam@quicinc.com
Subject: Re: [PATCH v12 6/8] spi: spi-qpic: add driver for QCOM SPI NAND
 flash Interface
Message-ID: <202410252355.ZofaMeku-lkp@intel.com>
References: <20241021115620.1616617-7-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021115620.1616617-7-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on broonie-spi/for-next robh/for-next linus/master v6.12-rc4 next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20241021-200849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20241021115620.1616617-7-quic_mdalam%40quicinc.com
patch subject: [PATCH v12 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
config: sparc64-randconfig-r073-20241023 (https://download.01.org/0day-ci/archive/20241025/202410252355.ZofaMeku-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410252355.ZofaMeku-lkp@intel.com/

smatch warnings:
drivers/spi/spi-qpic-snand.c:1260 qcom_spi_write_page() warn: unsigned 'cmd' is never less than zero.
drivers/spi/spi-qpic-snand.c:1279 qcom_spi_send_cmdaddr() warn: unsigned 'cmd' is never less than zero.

vim +/cmd +1260 drivers/spi/spi-qpic-snand.c

  1252	
  1253	static int qcom_spi_write_page(struct qcom_nand_controller *snandc,
  1254				       const struct spi_mem_op *op)
  1255	{
  1256		struct qpic_snand_op s_op = {};
  1257		u32 cmd;
  1258	
  1259		cmd = qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
> 1260		if (cmd < 0)
  1261			return cmd;
  1262	
  1263		s_op.cmd_reg = cmd;
  1264	
  1265		if (op->cmd.opcode == SPINAND_PROGRAM_LOAD)
  1266			snandc->qspi->data_buf = (u8 *)op->data.buf.out;
  1267	
  1268		return 0;
  1269	}
  1270	
  1271	static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
  1272					 const struct spi_mem_op *op)
  1273	{
  1274		struct qpic_snand_op s_op = {};
  1275		u32 cmd;
  1276		int ret, opcode;
  1277	
  1278		cmd = qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
> 1279		if (cmd < 0)
  1280			return cmd;
  1281	
  1282		s_op.cmd_reg = cmd;
  1283		s_op.addr1_reg = op->addr.val;
  1284		s_op.addr2_reg = 0;
  1285	
  1286		opcode = op->cmd.opcode;
  1287	
  1288		switch (opcode) {
  1289		case SPINAND_WRITE_EN:
  1290			return 0;
  1291		case SPINAND_PROGRAM_EXECUTE:
  1292			s_op.addr1_reg = op->addr.val << 16;
  1293			s_op.addr2_reg = op->addr.val >> 16 & 0xff;
  1294			snandc->qspi->addr1 = cpu_to_le32(s_op.addr1_reg);
  1295			snandc->qspi->addr2 = cpu_to_le32(s_op.addr2_reg);
  1296			snandc->qspi->cmd = cpu_to_le32(cmd);
  1297			return qcom_spi_program_execute(snandc, op);
  1298		case SPINAND_READ:
  1299			s_op.addr1_reg = (op->addr.val << 16);
  1300			s_op.addr2_reg = op->addr.val >> 16 & 0xff;
  1301			snandc->qspi->addr1 = cpu_to_le32(s_op.addr1_reg);
  1302			snandc->qspi->addr2 = cpu_to_le32(s_op.addr2_reg);
  1303			snandc->qspi->cmd = cpu_to_le32(cmd);
  1304			return 0;
  1305		case SPINAND_ERASE:
  1306			s_op.addr2_reg = (op->addr.val >> 16) & 0xffff;
  1307			s_op.addr1_reg = op->addr.val;
  1308			snandc->qspi->addr1 = cpu_to_le32(s_op.addr1_reg << 16);
  1309			snandc->qspi->addr2 = cpu_to_le32(s_op.addr2_reg);
  1310			snandc->qspi->cmd = cpu_to_le32(cmd);
  1311			qcom_spi_block_erase(snandc);
  1312			return 0;
  1313		default:
  1314			break;
  1315		}
  1316	
  1317		snandc->buf_count = 0;
  1318		snandc->buf_start = 0;
  1319		qcom_clear_read_regs(snandc);
  1320		qcom_clear_bam_transaction(snandc);
  1321	
  1322		snandc->regs->cmd = cpu_to_le32(s_op.cmd_reg);
  1323		snandc->regs->exec = cpu_to_le32(1);
  1324		snandc->regs->addr0 = cpu_to_le32(s_op.addr1_reg);
  1325		snandc->regs->addr1 = cpu_to_le32(s_op.addr2_reg);
  1326	
  1327		qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
  1328		qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
  1329	
  1330		ret = qcom_submit_descs(snandc);
  1331		if (ret)
  1332			dev_err(snandc->dev, "failure in submitting cmd descriptor\n");
  1333	
  1334		return ret;
  1335	}
  1336	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

