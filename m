Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9521A79AF
	for <lists+linux-spi@lfdr.de>; Tue, 14 Apr 2020 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439392AbgDNLhU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Apr 2020 07:37:20 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:6101
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439385AbgDNLhS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Apr 2020 07:37:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io9BAtG3H1YfJ45T/uE78+32Q3LYhPerjDkSeC8MjeurxVwcA8V92CVVl172lXns17r5QaWv3G7ayhTmuDKL99HWpE1GzsnsfQru5zB+2KlLpF26aiTuABlMw/eni8kUnkONx7Jw69iW9+4/UNk/+wNrJVdNIaKGlfVBdT7j9myAFcz4HSN1kh/B8m+2G0iWU9D4c0z+XDdu9tdWc7LmvHG7E+llCHyKeo5qPQL1IAinUL5q34dvtkzKMf2ehUeSKrHXoO1QzXzE8SiQIfFEUgvEW5fhzHWPEEF3yyGAC/7SBjrMv69Rcj2uV4RZQ55tDuI+bm+FgPbhNiXPQyXzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W58NGb60rPxmpQMJFRujTlW0RuEw+4y30s1zwErSVRA=;
 b=nc+M1wJ27SXtBIMU13Ct1Hzw62UEkp3fGR3qt37/Nx84QomH4I5e/EBoHm3KQXaNHcqLNMAUtMwN2STqTJMIDlJawwqZHzJasZNm2AOtzWe0tPDb1HY+KrFAWg3DEAjrU09lRoUpfZtYxlcVqnUh04H8qGHt54ZWA75i8+v2epvnbt/frvHg5Q5UTBr25UCK2o8zl908DbZQIHGWAXhNb2Jo65edh+WOvpeRMRAYDD2MD5zCbZaV+P2BLWzpKsxERJNIIb6znry2KQp8pQiJJcLLu1scaLwf/zzjm7l3W1TAViMbkN5XvmjHf+ko7SQqw03OeXeG7WWIOg7Naf1H9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W58NGb60rPxmpQMJFRujTlW0RuEw+4y30s1zwErSVRA=;
 b=MoY8/pLYRXS+2eBc6vL32mERG/YvdUiReX+TJ+0mKtanZERhIyh7m2Og37RxsQ93YrCrENHP+Ym4qXdtCUCZrzodeHgXXb0+4mfZ/zBU3Ux5ZBzDE4WYjI66TVBLXGQ3jPbdWi2RKzJ5D2ZBlCcAkNF9doAG4v+3AhY9beUTO5o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22)
 by MN2PR12MB3856.namprd12.prod.outlook.com (2603:10b6:208:168::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Tue, 14 Apr
 2020 11:37:15 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6%2]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 11:37:14 +0000
Subject: Re: Re: [PATCH] spi: spi-amd: Add AMD SPI controller driver support
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     Nehal-bakulchandra.Shah@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1586719711-46010-1-git-send-email-sanju.mehta@amd.com>
 <20200414111646.GC5412@sirena.org.uk>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <95455440-393d-f8aa-c213-dd746f184744@amd.com>
Date:   Tue, 14 Apr 2020 17:07:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200414111646.GC5412@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::19) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.32.32] (165.204.159.242) by PN1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 11:37:12 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e8f57c0-76b9-4ef2-05ba-08d7e0682da3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3856:|MN2PR12MB3856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3856A750496336902C8638EAE5DA0@MN2PR12MB3856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3455.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(66476007)(66946007)(6636002)(478600001)(2616005)(316002)(110136005)(5660300002)(53546011)(52116002)(16526019)(956004)(66556008)(6666004)(186003)(31696002)(26005)(16576012)(6486002)(4326008)(8936002)(81156014)(31686004)(8676002)(2906002)(36756003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2KOq8Zxbq1glTDl4ppQP4k9J6/6xSW/bvfpmIKP+lCoG/n73BNMQD1ecOJsEuXpGe0GqmZPG1ZkiEnVSNjg4SVkRctLbnfe5vbkmuN6YP1+CaMMvS6wxeMGr3KYmxzV6N163xB7dHbbSymBR1oWbPqQruc/yueV/5+YkdlxF4RzXkz8BkXXWwzmdlqqj1GHdIBhFeJo1LeFluo8OWNyx7gvFwEYeKfCh3WUCH+UZ5NHjut0IM4HEFOFG59CLMAKQXMKvCF7Rc5OqzJQGzGwp9zK1o1QO3HtoAbnUq0y+jfK51ZlNA6ZxkwZzvnlvK3A8pmjNIbRqawISuQtepCSlKedtfyeGM6FU57slI9vzN2MBB1hZsb312QVTqlNoAitFIcentkfb8pDGXj6ld/Hqa0oMD/449HV8JIkuc5D7azog7NmUJmRKp48PxYGAsi46
X-MS-Exchange-AntiSpam-MessageData: CxMKmbEeVWSaEXGHpmIFt11nPAabdY9a6TpHOVZwdExbYnnkoAG5EXn41jYe0k2yXBJiWI2ENAPKmveEPyM4/m1kC/y1WRzoQ8Bmb/CrRvs7P2JXg1BC+UPwJwDywLLUleh01oIgSUOrmyIcgPBILA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8f57c0-76b9-4ef2-05ba-08d7e0682da3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 11:37:14.7721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apS5xAKkqXhgNNutY59gCOGCxjbNAOu0ZJEmoode9y/TWdFYVJEoT8OozWgRLJa1Gf0ye/xI6eD6ceXN2cp9yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3856
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 4/14/2020 4:46 PM, Mark Brown wrote:
> On Sun, Apr 12, 2020 at 02:28:31PM -0500, Sanjay R Mehta wrote:
> 
>> +++ b/drivers/spi/spi-amd.c
>> @@ -0,0 +1,341 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +/*
>> + * AMD SPI controller driver
>> + *
> 
> Please make the entire comment a C++ one so things look more
> intentional.
> 
>> +#define DRIVER_NAME		"amd_spi"
> 
> This is unused.
> 
>> +/* M_CMD OP codes for SPI */
>> +#define SPI_XFER_TX		1
>> +#define SPI_XFER_RX		2
> 
> These constants should be namespaced, they're likely to collide with
> generic additions.
> 
>> +static void amd_spi_execute_opcode(struct spi_master *master)
>> +{
>> +	struct amd_spi *amd_spi = spi_master_get_devdata(master);
>> +	bool spi_busy;
>> +
>> +	/* Set ExecuteOpCode bit in the CTRL0 register */
>> +	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD,
>> +			       AMD_SPI_EXEC_CMD);
>> +
>> +	/* poll for SPI bus to become idle */
>> +	spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
>> +		    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
>> +	while (spi_busy) {
>> +		set_current_state(TASK_INTERRUPTIBLE);
>> +		schedule();
>> +		set_current_state(TASK_RUNNING);
>> +		spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
>> +			    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
>> +	}
> 
> This is a weird way to busy wait - usually you'd use a cpu_relax()
> rather than a schedule().  There's also no timeout here so we could busy
> wait for ever if something goes wrong.
> 
>> +static int amd_spi_master_setup(struct spi_device *spi)
>> +{
>> +	struct spi_master *master = spi->master;
>> +	struct amd_spi *amd_spi = spi_master_get_devdata(master);
>> +
>> +	amd_spi->chip_select = spi->chip_select;
>> +	amd_spi_select_chip(master);
> 
> This looks like it will potentially affect devices other than the
> current one.  setup() may be called while other devices are active it
> shouldn't do that.
> 
>> +		} else if (m_cmd & SPI_XFER_RX) {
>> +			/* Store no. of bytes to be received from
>> +			 * FIFO
>> +			 */
>> +			rx_len = xfer->len;
>> +			buffer = (u8 *)xfer->rx_buf;
> 
>> +		/* Read data from FIFO to receive buffer  */
>> +		for (i = 0; i < rx_len; i++)
>> +			buffer[i] = ioread8((u8 __iomem *)amd_spi->io_remap_addr
>> +					    + AMD_SPI_FIFO_BASE
>> +					    + tx_len + i);
> 
> This will only work for messages with a single receive transfer, if
> there are multiple transfers then you'll need to store multiple buffers
> and their lengths.
> 
>> +static int amd_spi_master_transfer(struct spi_master *master,
>> +				   struct spi_message *msg)
>> +{
>> +	struct amd_spi *amd_spi = spi_master_get_devdata(master);
>> +
>> +	/*
>> +	 * Extract spi_transfers from the spi message and
>> +	 * program the controller.
>> +	 */
>> +	amd_spi_fifo_xfer(amd_spi, msg);
>> +
>> +	return 0;
>> +}
> 
> This function is completely redundant, just inline amd_spi_fifo_xfer().
> It also ignores all errors which isn't great.
> 
>> +	/* Initialize the spi_master fields */
>> +	master->bus_num = 0;
>> +	master->num_chipselect = 4;
>> +	master->mode_bits = 0;
>> +	master->flags = 0;
> 
> This device is single duplex so should flag that.
> 
>> +	err = spi_register_master(master);
>> +	if (err) {
>> +		dev_err(dev, "error registering SPI controller\n");
>> +		goto err_iounmap;
> 
> It's best to print the error code to help people debug things.

Thanks Mark for the feedback. Will make all the suggested changes.
> 

