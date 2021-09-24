Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FE64172E8
	for <lists+linux-spi@lfdr.de>; Fri, 24 Sep 2021 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344611AbhIXMwY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Sep 2021 08:52:24 -0400
Received: from mail-bn8nam11on2052.outbound.protection.outlook.com ([40.107.236.52]:3168
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344338AbhIXMvA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Sep 2021 08:51:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7ACMsrikQ1zKRVWd31w+nLaQeh7/xjvPrv57phwKk3elGuZV3ngNMebg3NJKVTlN48RRSP9C9+U29qkW2mVB9fcNHBICRUDOr7X2fK6z1dM4xxNguEUROeH/p4E0HeJYVaqjMoKaMQuWT8Vl2StiGvQJWw2l7RcCZb9NA/wlvf3E9MZcixQNozcU/H4sHOufIMqiGsSg2OJtG1tyVVeYwr1JQJO1pLMHG/UJdatTuVuaaMPTUxE02I/QfjYk/YMdIqoCXzIHHVHo27o2B7t3X1X8fsl1R80sceatmfVQCF1BtCWx2VBRb6INJnvERxoNJIMpw5Cfbv5LeHTWR0rfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fbv2O8pr/+EyAUNEurRPCQ/oIo1ql9LxpTamT8leQpg=;
 b=LhGvDbn1ny1wylCfCTVlXN/xfAhJD/+KfwNTnKpZXHuAZcTy5T+w3DJmfE2CteNirOArkxdymsGC1Ka1XUxeDUPYrH4hoyDp141STdf06/Uy/h13K0ljM5lJR2l+H/qcjhs5lr7c6H1iug1j/M/ufoTIOE74naRPXm74aRNnXRFv8J4L6p3LuOWqmkoG8u8FQQ24OzqhCBV4UAAQKaQTihzik2Xv9Nd8vIrBKQ4kEm65dn31D33SvHj9r/+jwtSOeLqbKNRqodm/TStyEGNCx4gMnOBUiZTYEA6GxaVBBlKVLXbCQP/pl7ixRr37Z0jKeP0gMN4Zf+WRUqS1ujj//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=nigauri.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbv2O8pr/+EyAUNEurRPCQ/oIo1ql9LxpTamT8leQpg=;
 b=TKkzBDAx6v8fj6uczrgwghST9lLDyAPxKWTpQyKfrRAwSLV5uTsYnTScR3BXEfWR95d+Vlron76qoBcRET/0J/uisk169U8oLPbAmx4Z8UsBXDQbHxb0Xapb2SOC/hFZq2fd5LEZI5sgk5AJWWqBgHZ2mHmhnEofy4uu1gpDJPo=
Received: from DM5PR21CA0033.namprd21.prod.outlook.com (2603:10b6:3:ed::19) by
 MWHPR02MB2431.namprd02.prod.outlook.com (2603:10b6:300:3f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.18; Fri, 24 Sep 2021 12:49:24 +0000
Received: from DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::12) by DM5PR21CA0033.outlook.office365.com
 (2603:10b6:3:ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.0 via Frontend
 Transport; Fri, 24 Sep 2021 12:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; nigauri.org; dkim=none (message not signed)
 header.d=none;nigauri.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT056.mail.protection.outlook.com (10.13.4.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 12:49:24 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 05:49:14 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 05:49:14 -0700
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
Received: from [10.254.241.49] (port=33344)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mTkdc-000GdM-VZ; Fri, 24 Sep 2021 05:49:13 -0700
Subject: Re: [PATCH 1/4] firmware: xilinx: Add OSPI Mux selection support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
References: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1632478031-12242-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <YU24KEoXQOw/1uZV@kroah.com>
 <c588c9c4-df4b-a617-35d1-23c32654d5ff@xilinx.com>
 <YU3C7y833i9f0+yB@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <18d730a5-cec1-d699-a7cc-da8270a5dfe6@xilinx.com>
Date:   Fri, 24 Sep 2021 14:49:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YU3C7y833i9f0+yB@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9c37bb5-10d9-468b-1e3b-08d97f59bcb2
X-MS-TrafficTypeDiagnostic: MWHPR02MB2431:
X-Microsoft-Antispam-PRVS: <MWHPR02MB24312A9E445FA280651097DFC6A49@MWHPR02MB2431.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NynRwZJqWGxHkICFEIDjHxMRDCetU1R/Nm7rgQ6i9wJiWYraisjXFubd9wxT0Q1e81rOnTdmPuv7lmcyuW/fNtlZmILmzfp2TLM9XrZ1lqLdqo8tE0H54ct+/eZU8KT2bAt5gGdJfjAemENeb/fPI3x+5gkC17+x8LqqzWaoNQPapVWkp+RGeYtPTTYpFQM/4wAFm0Tr6eVcKUCmsj2AO4XClk1hhdLLfMxkXbKm1GNUiXLvF65t/qUzIEtM9+ZxdR3gJ4fAPkbh1Q3sk0B58BKpyLDQH0I2zGyZF5i4kY4sTzoTgZYq4tjKQMRQj6mU7EO51qBGsPaCMXFjv3NUhi8po+ljNAfVpIYBQQyHM2FZmXFzPCxA8X08XzS9s8TrkRw+gl44duv2YWYmdevl2oj6KMKY5v6gV6SAlTCqIyiBMmNeCs4jsA77nFNWsccE7iWbUR0xPiAc4exAapWRgSbN8oqgNWnBY2Awew8Cd1lU5P+dDBiUdSlMglJBE1qgyp0ZzkM2Du0XcuOKW+ZGvOMWLS+1RHfnG7pEKLgLwn6ic7s7X52Wm4PPsjaT67E17zs2YgCd/HjPi4Mozs3tkBLmKc6ooLcpHaL9bWFtqfGu7VHme4oI2/8jy5kvdGhwcL2gdlz36o1HQi2E/8KDCu0PZTgSV3vmi3ChDDxOzbKVjAtGeVsBLnsZ9kp9+uGVyegdIxMfqbzyp0VGqZYIxwTmVGFXisdiaa5ZDWlUmsI15TI6s8Q23mVLt/ti7KTT
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(6666004)(7416002)(31696002)(53546011)(9786002)(2906002)(186003)(70586007)(70206006)(8676002)(336012)(44832011)(82310400003)(47076005)(26005)(36860700001)(31686004)(7636003)(2616005)(426003)(36756003)(8936002)(508600001)(5660300002)(83380400001)(316002)(110136005)(54906003)(36906005)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 12:49:24.3342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c37bb5-10d9-468b-1e3b-08d97f59bcb2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2431
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 9/24/21 2:22 PM, Greg Kroah-Hartman wrote:
> On Fri, Sep 24, 2021 at 02:12:55PM +0200, Michal Simek wrote:
>>
>>
>> On 9/24/21 1:36 PM, Greg Kroah-Hartman wrote:
>>> On Fri, Sep 24, 2021 at 03:37:08PM +0530, Sai Krishna Potthuri wrote:
>>>> Add OSPI Mux selection API support to select the AXI interface to OSPI.
>>>>
>>>> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
>>>> ---
>>>>  drivers/firmware/xilinx/zynqmp.c     | 17 +++++++++++++++++
>>>>  include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++++++
>>>>  2 files changed, 29 insertions(+)
>>>>
>>>> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
>>>> index 15b138326ecc..43c3b5a9eef7 100644
>>>> --- a/drivers/firmware/xilinx/zynqmp.c
>>>> +++ b/drivers/firmware/xilinx/zynqmp.c
>>>> @@ -647,6 +647,23 @@ int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
>>>>  
>>>> +/**
>>>> + * zynqmp_pm_ospi_mux_select() - OSPI Mux selection
>>>> + *
>>>> + * @dev_id:	Device Id of the OSPI device.
>>>> + * @select:	OSPI Mux select value.
>>>> + *
>>>> + * This function select the OSPI Mux.
>>>> + *
>>>> + * Return:	Returns status, either success or error+reason
>>>> + */
>>>> +int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
>>>> +{
>>>> +	return zynqmp_pm_invoke_fn(PM_IOCTL, dev_id, IOCTL_OSPI_MUX_SELECT,
>>>> +				   select, 0, NULL);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
>>>> +
>>>>  /**
>>>>   * zynqmp_pm_write_ggs() - PM API for writing global general storage (ggs)
>>>>   * @index:	GGS register index
>>>> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
>>>> index 9d1a5c175065..6979a79f553a 100644
>>>> --- a/include/linux/firmware/xlnx-zynqmp.h
>>>> +++ b/include/linux/firmware/xlnx-zynqmp.h
>>>> @@ -119,6 +119,7 @@ enum pm_ioctl_id {
>>>>  	IOCTL_READ_PGGS = 15,
>>>>  	/* Set healthy bit value */
>>>>  	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
>>>> +	IOCTL_OSPI_MUX_SELECT = 21,
>>>
>>> Why the gap?  What are the commands in the middle for?
>>
>> Below is the full list. Not everything has been upstream yet. There was
>> an attempt on AFI which one colleague is working on and should send new
>> version soon. I don't think anybody has started with upstreaming probe
>> counters.
>> Every part has different owner with unfortunately own upstreaming plan.
>>
>> Thanks,
>> Michal
>>
>> enum pm_ioctl_id {
>> 	IOCTL_GET_RPU_OPER_MODE = 0,
>> 	IOCTL_SET_RPU_OPER_MODE = 1,
>> 	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
>> 	IOCTL_TCM_COMB_CONFIG = 3,
>> 	IOCTL_SET_TAPDELAY_BYPASS = 4,
>> 	IOCTL_SET_SGMII_MODE = 5,
>> 	IOCTL_SD_DLL_RESET = 6,
>> 	IOCTL_SET_SD_TAPDELAY = 7,
>> 	IOCTL_SET_PLL_FRAC_MODE = 8,
>> 	IOCTL_GET_PLL_FRAC_MODE = 9,
>> 	IOCTL_SET_PLL_FRAC_DATA = 10,
>> 	IOCTL_GET_PLL_FRAC_DATA = 11,
>> 	IOCTL_WRITE_GGS = 12,
>> 	IOCTL_READ_GGS = 13,
>> 	IOCTL_WRITE_PGGS = 14,
>> 	IOCTL_READ_PGGS = 15,
>> 	/* IOCTL for ULPI reset */
>> 	IOCTL_ULPI_RESET = 16,
>> 	/* Set healthy bit value */
>> 	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
>> 	IOCTL_AFI = 18,
>> 	/* Probe counter read/write */
>> 	IOCTL_PROBE_COUNTER_READ = 19,
>> 	IOCTL_PROBE_COUNTER_WRITE = 20,
>> 	IOCTL_OSPI_MUX_SELECT = 21,
>> 	/* IOCTL for USB power request */
>> 	IOCTL_USB_SET_STATE = 22,
>> 	/* IOCTL to get last reset reason */
>> 	IOCTL_GET_LAST_RESET_REASON = 23,
>> 	/* AI engine NPI ISR clear */
>> 	IOCTL_AIE_ISR_CLEAR = 24,
>> 	/* Register SGI to ATF */
>> 	IOCTL_REGISTER_SGI = 25,
>> 	/* Runtime feature configuration */
>> 	IOCTL_SET_FEATURE_CONFIG = 26,
>> 	IOCTL_GET_FEATURE_CONFIG = 27,
>> };
> 
> Odd mix of comments and no comments...
> 
> Anyway, that's fine, just curious as to why there was a gap.  No real
> reason why you can't just add them all now right?

Code is firstly integrated to soc tree and then upstream. I would love
to see this happen vise versa but still marketing wants to deliver
features first to customers. On the other hand customers care about
getting features on the first place and they are fine with not having
upstream solution first.
Back to your comment. It can also happen while upstreaming that some
numbers are simply not used because design is changed. That's why that
numbers can be skipped because it was just temporary solution or not
proper design.
It doesn't mean that these numbers can't be listed but on the other hand
why they should be listed if they shouldn't/can't be used.
That's why over time we are just adding number which are used by that
patchset.
I can't see any problem to send all of them if that's fine for you.

Thanks,
Michal
