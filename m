Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE9E41718F
	for <lists+linux-spi@lfdr.de>; Fri, 24 Sep 2021 14:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245135AbhIXMOh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Sep 2021 08:14:37 -0400
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:2016
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239965AbhIXMOg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Sep 2021 08:14:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+kdMSwZJ7MEPuehwi7e84OsrfEDqhtdHuwyHOx2iGfnAdssLQwj1AW/D8gA374e8mb2ECJBGmTviuTGja7Fmlp4C5Vh/VKAniznazuTR0f3VNpuDUreXe9EK9u7fQt+YJLbX5GVVFY9SFJVM7NpfKAhl855b16gH76HdCYnA7BpZBtGgBDncMsipxRo01MNLCNni+mRLEom49eGzRbWDPZll05tkYGOnY7NmcKo8vvXiOYsLE/2VpaTXo5zJmK3BNl4LY4SREmjZohIXhzXXq8Foo8V0TkJ9BD3mEVGnglBdwX3O1JpDm3e9hApm+BiwedXLPOXNO3/mQJiQDfjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qc6wboP26sOHt/GGyn8QI+3PhQQ0D7isIzmCJJ1XZA0=;
 b=gjiQFavCvE5bhZXgvLgZxyq5xm/4gFmmSAsqZzv3IwSqN0AysI9yp5+w6nc1BB+pTdQaFFfcKm9uQkaalzHAmNZnthpBQnh+Re3uaCyypAYn1VF8m7J+G6QRGQgXAiDsNcotj1RQF2MWqslWaN8g1sssYsxjwC0KOLy9EWOfeSjS8klAVGzhJU1KNM36sYtPNlr/P2tD5sDyqaDJoPPdmpP152UPYpR63KqpZYhs8x3ewLBnVWI9UAmGxfCHWekG/V22zUe9OxBpW8eR5PYyj55FbsRMpCFlOa+rmidfEZZEANLrznzbgGRywhfG8SiZuS7XSYF0ixvzUoWEHcNlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=nigauri.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc6wboP26sOHt/GGyn8QI+3PhQQ0D7isIzmCJJ1XZA0=;
 b=Tfct7Nm8wbyCL+ffbkgXrm08x8jGc7hkxfgQkeccjk/UDd7ecqBzyUxyjvH/vOj46YJGoAg2J5r/EwMuzacGccvN6iE21Cr6MS2i3F8eUwUuwO9duaq8oJM3xwO30y3J5xc5clRXL+1b8GFoHJ39ak2LNVhhNVpO1qPDW12mhRc=
Received: from SN7PR04CA0116.namprd04.prod.outlook.com (2603:10b6:806:122::31)
 by SN4PR0201MB8837.namprd02.prod.outlook.com (2603:10b6:806:204::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 12:13:01 +0000
Received: from SN1NAM02FT0057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:122:cafe::2) by SN7PR04CA0116.outlook.office365.com
 (2603:10b6:806:122::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 12:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; nigauri.org; dkim=none (message not signed)
 header.d=none;nigauri.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0057.mail.protection.outlook.com (10.97.4.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 12:13:01 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 05:13:00 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 05:13:00 -0700
Envelope-to: git@xilinx.com,
 iwamatsu@nigauri.org,
 arnd@arndb.de,
 saikrishna12468@gmail.com,
 linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 p.yadav@ti.com,
 robh+dt@kernel.org,
 broonie@kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.254.241.49] (port=58506)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mTk4Z-000Cos-3j; Fri, 24 Sep 2021 05:12:59 -0700
Subject: Re: [PATCH 1/4] firmware: xilinx: Add OSPI Mux selection support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
References: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1632478031-12242-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <YU24KEoXQOw/1uZV@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <c588c9c4-df4b-a617-35d1-23c32654d5ff@xilinx.com>
Date:   Fri, 24 Sep 2021 14:12:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YU24KEoXQOw/1uZV@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a25f979-cd11-4063-74b4-08d97f54a78c
X-MS-TrafficTypeDiagnostic: SN4PR0201MB8837:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB88374287E79B24C9CB664822C6A49@SN4PR0201MB8837.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x82gKwMHuZdDoVMKjoKgrhZ/mldefBrKSltVgec7SpVXnHqeYvI3zYmcBGfMH8RwIyTc5ylkBxQo4BWvxbwiff2XFhbDdLAbdB+EhqwW6SFUFGKt7J257ExDk3u7KxjqrfvKbHvk5KXmajo0ZWmWrPxjSSFIIlt1RPsmUJjbgRzriIlLGo1RLeJEfjEsMLNTZ+Q5rIuSRT+dTSgQ7cfvqil089ORoqx8M9MbB2GsTkEoZMOVxlmaCfO1Ukvv9l1zrOCp5Di8aHf8ZGbYgezM44PL3H0hdtoxi9bnQ+p4pP+9r52luF0GSY9GsIzerZq4hBwNK+fZCrl9Z/m8beptGdQZCBeDHsyrIomDjoez7jHnXiyG+cGTODJyLT8IMRi79scvo52jsToOKcpfn8JwxZ3cCyVA8nIObLos3DrTqVJmTlnl/nHpzMUmBEWTp5VjAL59CNXVDnx+OQ59if3qegSC7zVNm1/SEodPC7e1AoPPbOo2mDnMv2IqAmeVaHBSV5OF9p3mpGbxIek0pOn4PHTKgkiuloh0Wk3lpj1PHo5m0FyupbLDgzR+IzLn80ekPYps9vpveJLyE1OMHgAcwqEBWRoonkZKlPoE6vHBDr01tsItM7dVO+TgciDNoQyF7P4WmXI+lESUup3oIHNC1JGs1GQpHTGoOfjhp07r7zWL58tOhdUdTvMKZa2KfkYZMsnMwgDcSWbOwK13X2eHVQ1EqXlnPxw7YcLO8l8/QYIqC3cS7QR0UL2UthkFWWLr
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(53546011)(316002)(110136005)(508600001)(54906003)(7416002)(70586007)(9786002)(6666004)(36906005)(47076005)(8676002)(4326008)(6636002)(44832011)(36756003)(336012)(83380400001)(2906002)(26005)(8936002)(36860700001)(186003)(70206006)(5660300002)(2616005)(82310400003)(356005)(426003)(31686004)(7636003)(31696002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 12:13:01.3806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a25f979-cd11-4063-74b4-08d97f54a78c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8837
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 9/24/21 1:36 PM, Greg Kroah-Hartman wrote:
> On Fri, Sep 24, 2021 at 03:37:08PM +0530, Sai Krishna Potthuri wrote:
>> Add OSPI Mux selection API support to select the AXI interface to OSPI.
>>
>> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
>> ---
>>  drivers/firmware/xilinx/zynqmp.c     | 17 +++++++++++++++++
>>  include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++++++
>>  2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
>> index 15b138326ecc..43c3b5a9eef7 100644
>> --- a/drivers/firmware/xilinx/zynqmp.c
>> +++ b/drivers/firmware/xilinx/zynqmp.c
>> @@ -647,6 +647,23 @@ int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
>>  }
>>  EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
>>  
>> +/**
>> + * zynqmp_pm_ospi_mux_select() - OSPI Mux selection
>> + *
>> + * @dev_id:	Device Id of the OSPI device.
>> + * @select:	OSPI Mux select value.
>> + *
>> + * This function select the OSPI Mux.
>> + *
>> + * Return:	Returns status, either success or error+reason
>> + */
>> +int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
>> +{
>> +	return zynqmp_pm_invoke_fn(PM_IOCTL, dev_id, IOCTL_OSPI_MUX_SELECT,
>> +				   select, 0, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
>> +
>>  /**
>>   * zynqmp_pm_write_ggs() - PM API for writing global general storage (ggs)
>>   * @index:	GGS register index
>> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
>> index 9d1a5c175065..6979a79f553a 100644
>> --- a/include/linux/firmware/xlnx-zynqmp.h
>> +++ b/include/linux/firmware/xlnx-zynqmp.h
>> @@ -119,6 +119,7 @@ enum pm_ioctl_id {
>>  	IOCTL_READ_PGGS = 15,
>>  	/* Set healthy bit value */
>>  	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
>> +	IOCTL_OSPI_MUX_SELECT = 21,
> 
> Why the gap?  What are the commands in the middle for?

Below is the full list. Not everything has been upstream yet. There was
an attempt on AFI which one colleague is working on and should send new
version soon. I don't think anybody has started with upstreaming probe
counters.
Every part has different owner with unfortunately own upstreaming plan.

Thanks,
Michal

enum pm_ioctl_id {
	IOCTL_GET_RPU_OPER_MODE = 0,
	IOCTL_SET_RPU_OPER_MODE = 1,
	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
	IOCTL_TCM_COMB_CONFIG = 3,
	IOCTL_SET_TAPDELAY_BYPASS = 4,
	IOCTL_SET_SGMII_MODE = 5,
	IOCTL_SD_DLL_RESET = 6,
	IOCTL_SET_SD_TAPDELAY = 7,
	IOCTL_SET_PLL_FRAC_MODE = 8,
	IOCTL_GET_PLL_FRAC_MODE = 9,
	IOCTL_SET_PLL_FRAC_DATA = 10,
	IOCTL_GET_PLL_FRAC_DATA = 11,
	IOCTL_WRITE_GGS = 12,
	IOCTL_READ_GGS = 13,
	IOCTL_WRITE_PGGS = 14,
	IOCTL_READ_PGGS = 15,
	/* IOCTL for ULPI reset */
	IOCTL_ULPI_RESET = 16,
	/* Set healthy bit value */
	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
	IOCTL_AFI = 18,
	/* Probe counter read/write */
	IOCTL_PROBE_COUNTER_READ = 19,
	IOCTL_PROBE_COUNTER_WRITE = 20,
	IOCTL_OSPI_MUX_SELECT = 21,
	/* IOCTL for USB power request */
	IOCTL_USB_SET_STATE = 22,
	/* IOCTL to get last reset reason */
	IOCTL_GET_LAST_RESET_REASON = 23,
	/* AI engine NPI ISR clear */
	IOCTL_AIE_ISR_CLEAR = 24,
	/* Register SGI to ATF */
	IOCTL_REGISTER_SGI = 25,
	/* Runtime feature configuration */
	IOCTL_SET_FEATURE_CONFIG = 26,
	IOCTL_GET_FEATURE_CONFIG = 27,
};
