Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C616591C
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2020 09:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgBTIYI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Feb 2020 03:24:08 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:4898 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726759AbgBTIYI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Feb 2020 03:24:08 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01K8Nsn6032485;
        Thu, 20 Feb 2020 00:24:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=proofpoint;
 bh=JBnWU8zsxIu7ZhNhPemdJ8pd9t0/DkxnkEuxJ+/g0ts=;
 b=QQoz1wD7qfccPJiotHmFLUYorayIlKNy9q7GrNQrYWUFOsjLxsoM34WPI+96424pIbfr
 XYcdLraTPH7AY/vo+xH/TwtbSGLnRM7yjmjzh3P7StUeXDqYItkH0rDz9pG/uTIJKpEd
 uYYOx+WRiJQZoRxITtEDviUUWHfOdEVVRpU0aXG1UqsYzRz/2ruQp2uVlqI7p4Qq63Eu
 zc5GdSHuOnMHI2wN8FNVlRI+e86oq5QWVv2DrDwxlXwLbiQ7UP8IuBqIfBuU1HJdmBb+
 PqCGGjJMpZtto76UlfWeabTkun76QX4Jh1AnS1sxkuY5blhpZSZvw1yeQk/xjyejgIWL WA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2y8ubjwwxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Feb 2020 00:24:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+i6hm5rl1Jk7yPFkf9dk7t36iCvf77HrsumSJEqUli+HyeFq2w6EI+2uGSsZkTMgnXw1PaRmMm7H67Zjzm7/QaCWz6pJcmpFGf0gdSSDI5hw28u6c6y1FqeN7ezPI8hOlwca5QTN1dNb3/5w+ormSPbCtQJ3488sENHu1V2dY2mV9QT2Pfp+nm9WYSSf8hLMACbyTCVFi9su4Pj+1qi0veeA+SFfoiXGr3/crOV3v07UOLEessjg92lZycKi3nXGsgeH/D+U0nQBfN9ddpshZwynEEH19YhVbWCjOHeuUPCCEvRWKoXPIUoEE/VP40HkgZBSaXmSntCikUUzcHHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBnWU8zsxIu7ZhNhPemdJ8pd9t0/DkxnkEuxJ+/g0ts=;
 b=lvC0ySca5zOld2MEmlwgdmEnA2/QsBed0la99EwRqzVX2A0VX6B3wJOIEmvUpkw7tfVAhZransIXAVBtsuzMN8yo2ASaE8aege0/ldB/8/mIvBGVuesewvvN6A721fmjihyFfQU9PGF4bLB3Z6QcCgb+di9tPTwRtFtdwpl2tUeVwmYuyqfYOXYCdx+kul621ml/kxQ22sU4eyU0lLmkCAwQ6btxW1YOOHk2i0K68uu7lj1hgcfi+HXHKLc85kCbW/wRiqXf3Dpon2p6eYDJKkPZl7MAt5g9IqaTVDtdAc7N3EHAGMEvCpsBdVf3qPD5LIlF02Zg7ALkM6GpvQkGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBnWU8zsxIu7ZhNhPemdJ8pd9t0/DkxnkEuxJ+/g0ts=;
 b=D21GzakJ9AWEmEaEBr/Mg+WhLUQe1hNd0mzV5QgRZy47hQyjCzPEXgcX+eDeqpfVpwWPk1oY/rdcehWp2n26XUam2rUQYvIQ/Z7h8zONuF3k5vGwaNgccd7M2dCrnXxo2xuAyg/b9RFeBtxtEM6Jzii7rBw2+rRMqcuPhLZK0Rk=
Received: from DM5PR07CA0036.namprd07.prod.outlook.com (2603:10b6:3:16::22) by
 BL0PR07MB5761.namprd07.prod.outlook.com (2603:10b6:208:80::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 20 Feb 2020 08:24:01 +0000
Received: from MW2NAM12FT063.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::200) by DM5PR07CA0036.outlook.office365.com
 (2603:10b6:3:16::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Thu, 20 Feb 2020 08:24:01 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 MW2NAM12FT063.mail.protection.outlook.com (10.13.181.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.12 via Frontend Transport; Thu, 20 Feb 2020 08:24:00 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 01K8O0HJ012651
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 20 Feb 2020 00:24:00 -0800
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 20 Feb 2020 00:23:59 -0800
Date:   Thu, 20 Feb 2020 09:23:56 +0100
From:   Konrad Kociolek <konrad@cadence.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Add Cadence XSPI driver
Message-ID: <20200220082354.GA15619@global.cadence.com>
References: <20200128124212.12298-1-konrad@cadence.com>
 <20200210191620.GE14166@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20200210191620.GE14166@sirena.org.uk>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj6.global.cadence.com (158.140.32.112) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(199004)(189003)(36092001)(54906003)(4326008)(55016002)(5660300002)(246002)(26005)(478600001)(7636002)(70206006)(426003)(2906002)(8936002)(316002)(6286002)(336012)(8676002)(33656002)(6916009)(956004)(1076003)(186003)(16526019)(6666004)(86362001)(7696005)(26826003)(356004)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB5761;H:sjmaillnx2.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c74a2d83-0f90-4abe-07ac-08d7b5de3d0b
X-MS-TrafficTypeDiagnostic: BL0PR07MB5761:
X-Microsoft-Antispam-PRVS: <BL0PR07MB576133BBC77907717129EF7BC3130@BL0PR07MB5761.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 031996B7EF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDWpFECFeW3C+0xRwh4iBFgapmb5D7oXBJKTNk9Xluh89joEfO5ExoyaP0RV8IxxmaRdhJ6Hf//owdz6wi447BVdfqtUFoumrPo8oOSYIAIi/Bw6u+JEuVhN9i4WstIhUOFD1NJGvOC8SizwaKRRC5lpTROrBG8MbqFde25g0tV0dRglZAylINvkJX5isXuJjN2eW8sBvU+f2kt1+B5OFgzC0lmGWizQUkiM209TIPNnqOzzdqQOZNDA9150f+LeyKYdJ4ZufItAn175IzLpSLvDiYdcgfbpBBzgk4WOuM6Miq7Q1Wc3c8lOF0fsyZ3KZLRMsVFd9zjA/Nfn2gVEu5v3yJ+cpl/YVwE36/+4mNikcJ05tD9BYA4uVUkKs+okGatpAfQN7FEUMkF22TH5mU6W0R/pN1re5Qu3mGoVbHhcXSftDsNhC3wJTDuzfh2/CUCugOGGAoiTjgNJxU5IUuU/h5+6exRLq2YVvtY56yVdiExqUqdSeeynxPTJDOuj
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 08:24:00.7155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c74a2d83-0f90-4abe-07ac-08d7b5de3d0b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5761
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_02:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200062
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 02/10/2020 19:16, Mark Brown wrote:
>EXTERNAL MAIL
>
>
>On Tue, Jan 28, 2020 at 01:41:57PM +0100, Konrad Kociolek wrote:
>
>>  	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
>>
>> +config SPI_CADENCE_XSPI
>> +	tristate "Cadence XSPI controller"
>> +	depends on (OF || COMPILE_TEST) && HAS_IOMEM
>> +	help
>> +	  Enable support for the Cadence XSPI Flash controller.
>> +
>> +	  Cadence XSPI is a specialized controller for connecting an SPI
>> +	  Flash over upto 8bit wide bus. Enable this option if you have a
>> +	  device with a Cadence XSPI controller and want to access the
>> +	  Flash as an MTD device.
>> +
>>  #
>>  # Add new SPI master controllers in alphabetical order above this line
>>  #
>
>Please keep Kconfig and Makefile alphabetically sorted as the comment in
>the context from the diff says.  :/
>
What I see is Kconfig is first and Makefile is second file in diff,
according to:
  drivers/spi/Kconfig            |  11 +
  drivers/spi/Makefile           |   1 +
Is that wrong?
>> --- /dev/null
>> +++ b/drivers/spi/spi-cadence-xspi.c
>> @@ -0,0 +1,895 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Cadence XSPI flash controller driver
>
>Please make the entire comment a C++ so things look more intentional.
>
>> +	dev_info(cdns_xspi->dev,
>> +		"Running PHY training for read_dqs_delay parameter\n");
>
>This print is just noise, please remove it.
>
>> +static int cdns_xspi_setup(struct spi_device *spi_dev)
>> +{
>> +	if (spi_dev->chip_select > spi_dev->master->num_chipselect) {
>> +		dev_err(&spi_dev->dev,
>> +			"%d chip-select is out of range\n",
>> +			spi_dev->chip_select);
>> +		return -EINVAL;
>> +	}
>
>If this isn't already being validated by the core it should be and this
>function can be removed.
>
>> +	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
>> +	if (irq_status) {
>> +		writel(irq_status,
>> +			cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
>
>This unconditionally acknowledges everything, even things we don't
>understand.  If the hardware is generating unexpected interrupt statuses
>we should probably warn.
>
>> +static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
>> +{
>> +	struct device *dev = cdns_xspi->dev;
>> +
>> +	dev_info(dev, "PHY configuration\n");
>> +	dev_info(dev, "   * xspi_dll_phy_ctrl: %08x\n",
>> +		readl(cdns_xspi->iobase + CDNS_XSPI_DLL_PHY_CTRL));
>> +	dev_info(dev, "   * phy_dq_timing: %08x\n",
>> +		readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQ_TIMING));
>> +	dev_info(dev, "   * phy_dqs_timing: %08x\n",
>> +		readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQS_TIMING));
>> +	dev_info(dev, "   * phy_gate_loopback_ctrl: %08x\n",
>> +		readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL));
>> +	dev_info(dev, "   * phy_dll_slave_ctrl: %08x\n",
>> +		readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
>> +}
>
>This seems pretty verbose for an individual device...  If this is needed
>for diagnostics perhaps put it in sysfs or debugfs where it'll be
>accessible even if the log wraps?
>
>> +err_no_mem:
>> +	dev_err(dev, "Failed to probe Cadence XSPI controller driver\n");
>
>Not sure this is adding anything over the individual error messages on
>specific failures.
>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id cdns_xspi_of_match[] = {
>> +	{
>> +		.compatible = "cdns,xspi-nor-fpga",
>> +	},
>
>Why -fpga?
This is because this driver was tested only on FPGA board.
This driver was not tested for ASIC version as PHY
initialization algorithm is differ.



-- 
--
Konrad Kociolek
