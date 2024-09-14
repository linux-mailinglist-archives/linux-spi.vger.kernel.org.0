Return-Path: <linux-spi+bounces-4818-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B02C979099
	for <lists+linux-spi@lfdr.de>; Sat, 14 Sep 2024 13:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F4328441B
	for <lists+linux-spi@lfdr.de>; Sat, 14 Sep 2024 11:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCDA1CF2B1;
	Sat, 14 Sep 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpjSPCEk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA0E13BC11;
	Sat, 14 Sep 2024 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726314185; cv=none; b=uKsIU/aUv1I9HENkJbYkMxtIBluGgX3sWvjbHoh7Va1j2KuoLeXI3P87cbl0r6IGvsW17NK8cNTB9yvJs7OqCllHJdVyZX2gSylFTqd4BRme7+6I0FKOdLAzDgAnXiGGtb25sXOm4gCwXEwSM8/8RDp6pgjiYAOBhwnnxGCEJg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726314185; c=relaxed/simple;
	bh=IttjkCQSBf9NbEnR71sQfuFl0VYCaS4hWpmUrJuBJNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQM4Iy6GehnOa8pBlyA4aKsdS+4guv+wCXwILi8gUebuJtpgW9Ne03uzvzXosrJWwxz9KaCpxAdaK3GxxodQFEuKvYugYi37yo6efCQis8VPvQIp33w+CnYtjdubscTY/DjXo3DAdWZh0i2xw0Ljx71Kn75gON9345a9Mcc8BJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpjSPCEk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726314184; x=1757850184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IttjkCQSBf9NbEnR71sQfuFl0VYCaS4hWpmUrJuBJNY=;
  b=lpjSPCEkJzVIjdqjWF9Fs2CrKJ9JwtdaBukb+yjHXZnNHFCfc6n6OuSw
   67Hx4mSXd7scCzXwc1rLVn+FTEPgTzTnkKdhcjBkfj4rsDxmlvCP9rMIS
   yOejcVRLkRB/Suj+FiMZeSo13ir/RStAR1gqbbfpMpQClWXCgEgfVTcsa
   wlcbxAiLcX43Flubx2LsH8Di9tmcJ9ei5q1dUcPy4JT0mV8Tz6TJ+gGyf
   6pObaVOFuGLSnzeIMe3S0Unre0rakeJ1OGjJh0fdpa8iqm5AyASxKAyRc
   HN03FYzhZUdhCmtRlRfmad7kbfGk59ZSE0QleeTLgsOxULw75FWGwsj2E
   w==;
X-CSE-ConnectionGUID: frR57wI3T4OEGtkT5W+1lA==
X-CSE-MsgGUID: 7SQx83xTR/eZqQugS4TRJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="29107109"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="29107109"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 04:43:03 -0700
X-CSE-ConnectionGUID: cfdzYlx5R22BuSAhdqbY4w==
X-CSE-MsgGUID: gcHHmbr1RCa6kfZjHkpXOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="68887902"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 14 Sep 2024 04:42:58 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spRB1-0007i6-1K;
	Sat, 14 Sep 2024 11:42:55 +0000
Date: Sat, 14 Sep 2024 19:42:53 +0800
From: kernel test robot <lkp@intel.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, esben@geanix.com,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, quic_mdalam@quicinc.com,
	quic_varada@quicinc.com, quic_srichara@quicinc.com
Subject: Re: [PATCH v9 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash
 Interface
Message-ID: <202409141932.JyCSfNIc-lkp@intel.com>
References: <20240912061503.3468147-7-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912061503.3468147-7-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build errors:

[auto build test ERROR on mtd/nand/next]
[also build test ERROR on broonie-spi/for-next robh/for-next linus/master v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20240912-141925
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20240912061503.3468147-7-quic_mdalam%40quicinc.com
patch subject: [PATCH v9 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
config: arm64-randconfig-r063-20240914 (https://download.01.org/0day-ci/archive/20240914/202409141932.JyCSfNIc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409141932.JyCSfNIc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409141932.JyCSfNIc-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/spi/spi-qpic-snand.o: in function `qcom_spi_remove':
>> drivers/spi/spi-qpic-snand.c:1597:(.text+0x1f8): undefined reference to `qcom_nandc_unalloc'
   aarch64-linux-ld: drivers/spi/spi-qpic-snand.o: in function `qcom_spi_probe':
>> drivers/spi/spi-qpic-snand.c:1540:(.text+0x680): undefined reference to `qcom_nandc_alloc'
   aarch64-linux-ld: drivers/spi/spi-qpic-snand.o: in function `qcom_spi_init':
>> drivers/spi/spi-qpic-snand.c:192:(.text+0x6d0): undefined reference to `qcom_write_reg_dma'
>> aarch64-linux-ld: drivers/spi/spi-qpic-snand.c:197:(.text+0x6f4): undefined reference to `qcom_write_reg_dma'
   aarch64-linux-ld: drivers/spi/spi-qpic-snand.c:199:(.text+0x710): undefined reference to `qcom_write_reg_dma'
   aarch64-linux-ld: drivers/spi/spi-qpic-snand.c:200:(.text+0x72c): undefined reference to `qcom_write_reg_dma'
>> aarch64-linux-ld: drivers/spi/spi-qpic-snand.c:203:(.text+0x734): undefined reference to `qcom_submit_descs'
   aarch64-linux-ld: drivers/spi/spi-qpic-snand.o: in function `qcom_spi_probe':
   drivers/spi/spi-qpic-snand.c:1576:(.text+0x754): undefined reference to `qcom_nandc_unalloc'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_submit_wmt_recv_urb':
   drivers/bluetooth/btmtk.c:531:(.text+0x928): undefined reference to `usb_alloc_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:537:(.text+0x958): undefined reference to `usb_free_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:550:(.text+0x998): undefined reference to `usb_free_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:561:(.text+0x9ec): undefined reference to `usb_anchor_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:562:(.text+0x9f8): undefined reference to `usb_submit_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:567:(.text+0xa3c): undefined reference to `usb_unanchor_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:570:(.text+0xa44): undefined reference to `usb_free_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_submit_intr_urb':
   drivers/bluetooth/btmtk.c:1174:(.text+0xab4): undefined reference to `usb_alloc_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:1181:(.text+0xadc): undefined reference to `usb_free_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:1195:(.text+0xb94): undefined reference to `usb_anchor_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:1197:(.text+0xba0): undefined reference to `usb_submit_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:1202:(.text+0xbe4): undefined reference to `usb_unanchor_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:1205:(.text+0xbec): undefined reference to `usb_free_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_suspend':
   drivers/bluetooth/btmtk.c:1265:(.text+0xce0): undefined reference to `usb_kill_anchored_urbs'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_hci_wmt_sync':
   drivers/bluetooth/btmtk.c:610:(.text+0xdc0): undefined reference to `usb_autopm_get_interface'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:618:(.text+0xe24): undefined reference to `usb_autopm_put_interface'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:625:(.text+0xe3c): undefined reference to `usb_autopm_put_interface'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_recv_acl':
   drivers/bluetooth/btmtk.c:946:(.text+0x13a0): undefined reference to `usb_disable_autosuspend'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `__set_mtk_intr_interface':
   drivers/bluetooth/btmtk.c:991:(.text+0x14c8): undefined reference to `usb_set_interface'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_isointf_init':
   drivers/bluetooth/btmtk.c:1224:(.text+0x15d8): undefined reference to `usb_kill_anchored_urbs'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_wmt_recv':
   drivers/bluetooth/btmtk.c:508:(.text+0x1884): undefined reference to `usb_anchor_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:509:(.text+0x1890): undefined reference to `usb_submit_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:518:(.text+0x18dc): undefined reference to `usb_unanchor_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `alloc_mtk_intr_urb':
   drivers/bluetooth/btmtk.c:1037:(.text+0x1958): undefined reference to `usb_alloc_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_reg_read':
   drivers/bluetooth/btmtk.c:790:(.text+0x1af0): undefined reference to `usb_control_msg'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_write':
   drivers/bluetooth/btmtk.c:738:(.text+0x1bd0): undefined reference to `usb_control_msg'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_read':
   drivers/bluetooth/btmtk.c:761:(.text+0x1cbc): undefined reference to `usb_control_msg'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_intr_complete':
   drivers/bluetooth/btmtk.c:1145:(.text+0x1f48): undefined reference to `usb_anchor_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:1147:(.text+0x1f54): undefined reference to `usb_submit_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:1157:(.text+0x1fb4): undefined reference to `usb_unanchor_urb'


vim +1597 drivers/spi/spi-qpic-snand.c

  1463	
  1464	static int qcom_spi_probe(struct platform_device *pdev)
  1465	{
  1466		struct device *dev = &pdev->dev;
  1467		struct spi_controller *ctlr;
  1468		struct qcom_nand_controller *snandc;
  1469		struct qpic_spi_nand *qspi;
  1470		struct qpic_ecc *ecc;
  1471		struct resource *res;
  1472		const void *dev_data;
  1473		int ret;
  1474	
  1475		ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
  1476		if (!ecc)
  1477			return -ENOMEM;
  1478	
  1479		qspi = devm_kzalloc(dev, sizeof(*qspi), GFP_KERNEL);
  1480		if (!qspi)
  1481			return -ENOMEM;
  1482	
  1483		ctlr = __devm_spi_alloc_controller(dev, sizeof(*snandc), false);
  1484		if (!ctlr)
  1485			return -ENOMEM;
  1486	
  1487		platform_set_drvdata(pdev, ctlr);
  1488	
  1489		snandc = spi_controller_get_devdata(ctlr);
  1490		qspi->snandc = snandc;
  1491	
  1492		snandc->dev = dev;
  1493		snandc->qspi = qspi;
  1494		snandc->qspi->ctlr = ctlr;
  1495		snandc->qspi->ecc = ecc;
  1496	
  1497		dev_data = of_device_get_match_data(dev);
  1498		if (!dev_data) {
  1499			dev_err(&pdev->dev, "failed to get device data\n");
  1500			return -ENODEV;
  1501		}
  1502	
  1503		snandc->props = dev_data;
  1504		snandc->dev = &pdev->dev;
  1505	
  1506		snandc->core_clk = devm_clk_get(dev, "core");
  1507		if (IS_ERR(snandc->core_clk))
  1508			return PTR_ERR(snandc->core_clk);
  1509	
  1510		snandc->aon_clk = devm_clk_get(dev, "aon");
  1511		if (IS_ERR(snandc->aon_clk))
  1512			return PTR_ERR(snandc->aon_clk);
  1513	
  1514		snandc->qspi->iomacro_clk = devm_clk_get(dev, "iom");
  1515		if (IS_ERR(snandc->qspi->iomacro_clk))
  1516			return PTR_ERR(snandc->qspi->iomacro_clk);
  1517	
  1518		snandc->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
  1519		if (IS_ERR(snandc->base))
  1520			return PTR_ERR(snandc->base);
  1521	
  1522		snandc->base_phys = res->start;
  1523		snandc->base_dma = dma_map_resource(dev, res->start, resource_size(res),
  1524						    DMA_BIDIRECTIONAL, 0);
  1525		if (dma_mapping_error(dev, snandc->base_dma))
  1526			return -ENXIO;
  1527	
  1528		ret = clk_prepare_enable(snandc->core_clk);
  1529		if (ret)
  1530			goto err_dis_core_clk;
  1531	
  1532		ret = clk_prepare_enable(snandc->aon_clk);
  1533		if (ret)
  1534			goto err_dis_aon_clk;
  1535	
  1536		ret = clk_prepare_enable(snandc->qspi->iomacro_clk);
  1537		if (ret)
  1538			goto err_dis_iom_clk;
  1539	
> 1540		ret = qcom_nandc_alloc(snandc);
  1541		if (ret)
  1542			goto err_snand_alloc;
  1543	
  1544		ret = qcom_spi_init(snandc);
  1545		if (ret)
  1546			goto err_spi_init;
  1547	
  1548		/* setup ECC engine */
  1549		snandc->qspi->ecc_eng.dev = &pdev->dev;
  1550		snandc->qspi->ecc_eng.integration = NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
  1551		snandc->qspi->ecc_eng.ops = &qcom_spi_ecc_engine_ops_pipelined;
  1552		snandc->qspi->ecc_eng.priv = snandc;
  1553	
  1554		ret = nand_ecc_register_on_host_hw_engine(&snandc->qspi->ecc_eng);
  1555		if (ret) {
  1556			dev_err(&pdev->dev, "failed to register ecc engine:%d\n", ret);
  1557			goto err_spi_init;
  1558		}
  1559	
  1560		ctlr->num_chipselect = QPIC_QSPI_NUM_CS;
  1561		ctlr->mem_ops = &qcom_spi_mem_ops;
  1562		ctlr->mem_caps = &qcom_spi_mem_caps;
  1563		ctlr->dev.of_node = pdev->dev.of_node;
  1564		ctlr->mode_bits = SPI_TX_DUAL | SPI_RX_DUAL |
  1565				    SPI_TX_QUAD | SPI_RX_QUAD;
  1566	
  1567		ret = spi_register_controller(ctlr);
  1568		if (ret) {
  1569			dev_err(&pdev->dev, "spi_register_controller failed.\n");
  1570			goto err_spi_init;
  1571		}
  1572	
  1573		return 0;
  1574	
  1575	err_spi_init:
  1576		qcom_nandc_unalloc(snandc);
  1577	err_snand_alloc:
  1578		clk_disable_unprepare(snandc->qspi->iomacro_clk);
  1579	err_dis_iom_clk:
  1580		clk_disable_unprepare(snandc->aon_clk);
  1581	err_dis_aon_clk:
  1582		clk_disable_unprepare(snandc->core_clk);
  1583	err_dis_core_clk:
  1584		dma_unmap_resource(dev, res->start, resource_size(res),
  1585				   DMA_BIDIRECTIONAL, 0);
  1586		return ret;
  1587	}
  1588	
  1589	static void qcom_spi_remove(struct platform_device *pdev)
  1590	{
  1591		struct spi_controller *ctlr = platform_get_drvdata(pdev);
  1592		struct qcom_nand_controller *snandc = spi_controller_get_devdata(ctlr);
  1593		struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1594	
  1595		spi_unregister_controller(ctlr);
  1596	
> 1597		qcom_nandc_unalloc(snandc);
  1598	
  1599		clk_disable_unprepare(snandc->aon_clk);
  1600		clk_disable_unprepare(snandc->core_clk);
  1601		clk_disable_unprepare(snandc->qspi->iomacro_clk);
  1602	
  1603		dma_unmap_resource(&pdev->dev, snandc->base_dma, resource_size(res),
  1604				   DMA_BIDIRECTIONAL, 0);
  1605	}
  1606	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

