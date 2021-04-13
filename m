Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A82935DDFD
	for <lists+linux-spi@lfdr.de>; Tue, 13 Apr 2021 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbhDMLqL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Apr 2021 07:46:11 -0400
Received: from mail-bn7nam10on2060.outbound.protection.outlook.com ([40.107.92.60]:35878
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238852AbhDMLqL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Apr 2021 07:46:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSX25p0SPa3ec7umPvidknVWGEmMe1+zSCegvpKVZlmtBGdr0rZqaYZ7W3AUyJ0dtQtdQ8JP2NciTERwxXenfFfyUIcGMkBIvSg+wQGkJdzsuELfPncYnWFXM7+SNW9V4drCkeFJUf33AVgkvrrcho1y30fd5FEB+aHjd1cfk3a/V/7m08F/ExRh3yMgbFTFRuLA0PvIizfYbFdO9rfrrk0JsWVOw7EGizPbIZvypmT/FLAzlj91UPNy7IXjzh9Szpg5FzWnNNDSg6RLnz0O6ur6aoRYKoZ+4vaA4SCBIpciPq2Cz2UwYvD41suU9p6eQKcjQK/CfVXPGhte+vU1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z26STTgwhGdjHmNGkUCC4DxDCzmI/CwS2/NKd9Us0Mw=;
 b=lmewFONPh9n7e1SxjRCqMKJeLDp84PSESeOI5lqthPZ0TOJ2Q1exm845OInSTbMVsQmklEi4vpCtT+ABfWFj0iS0szuTrk+uwNC326y7mFHS164zrjc14OraG6cNorNpNk87f74m0dg1/1qw81r+oyNvQCBsoU80sH6329y2NMD+0Z8QDmE2KaCMDaDYGu13IQIwCi8D9IAvDJY9AgYRiMLlSG0vjABoSPY+ztxXG9lcTa8e4CC6rW9P5ECxFkQjZshBBaAY/CymgkG+gnYfvE0LJPzd76xNOGbdx4wasJbs11/5kyeZisUN8aGpkkDUVZgwzOszDr9RpIAGkHl6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z26STTgwhGdjHmNGkUCC4DxDCzmI/CwS2/NKd9Us0Mw=;
 b=B+DSjMWN6XUAVUni+LarO+pPMSxafnN3vUrQi0YWnFV8EXI+iQKVX/v5gt3YMI2YrUOBIy3qEPI1nBGsxi88hVOCBqp0uFxYJSBk4cSiEd44ahDXOlrJpFjo97zIUNGu0f2hb7xkMCxhKdi5tbWBXQ8x3JN+Wp7EoxXov7L0cwI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1544.namprd11.prod.outlook.com (2603:10b6:910:d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 11:45:50 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Tue, 13 Apr 2021
 11:45:50 +0000
Subject: Re: [PATCH] spi: spi-zynqmp-gqspi: unlock on error path in exec_op
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YHV3gkc3RFcBZVAK@mwanda>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <3b918af4-2885-7ca9-855e-005798d50761@windriver.com>
Date:   Tue, 13 Apr 2021 19:44:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YHV3gkc3RFcBZVAK@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:202:17::22) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by HK2PR03CA0052.apcprd03.prod.outlook.com (2603:1096:202:17::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Tue, 13 Apr 2021 11:45:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e42d63a9-54d8-44df-f334-08d8fe71af4d
X-MS-TrafficTypeDiagnostic: CY4PR11MB1544:
X-Microsoft-Antispam-PRVS: <CY4PR11MB15449799DAA21D83B8C6811DF04F9@CY4PR11MB1544.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQSdv46tQGpc6lGAYRSM+CaMP4VHUODGGTUWGGkYFPHCzW61TSlmoYRSsJpxWkS3FlRnCgNrxvp99Jqes2xQey1nl2ZCwhGrOVPtuP+S2uzq6KjKO7kZ+P5fwbZU2657XgmvhIQotbgcodKonuXgz8CycBlZcc5uPl0jgKbJ8w5Z1Igpob05t07LDENwAoZ5NMPluf3S/2JN4d41SCf7YNZFc7f+Wmsktb/Yy0b0MFIBvkNaFN87AxQPGJpLy4ddrzHJJnjIwcyi9SKiq9RTQc6/J30WVsmicfli9c6TTICI2V4VqKMD+ErPk9UQuVqfVygcUzSPriMZkJyjTxsD+2XcLTS+xQ0MLZ5GIkNjPknwSx7uSdTR9rb0uz44mm/ZokMkgPzJei+qpb0LOVtiPAXWrryPEuzJF3WMIGvSnyqs/5qTgTpdf+ibLi1renhZyIG4BkRt7yOCn10kHpHGUb0S0hplBoDZIugWMAVJ6GPWDyQ1IX2LpraAlCZc6NwnDnkgXMiZwdL+Q6TXowgg874qK9zEUKKysyeX1PoR5Bxk2TlNO9An+z8peZHoe8ndd1m3Eb6OvfWHCI76sE3pPbsRy9pr4eVQxAeOLLBCEvSV5YkQi0IRglchc0qw0ZujBhDK1U/7WH9Ta547PZcIbcxoUCMZqTGl8/K0l2M4QZpPV0WimEnh4kF8wqdlNWUHn67JA6a0FD1B+jTgmMvv46wHbT/m31w0i0OUYzG5/+r0AKGDnQ5th0JMX9yAWuA5N6rpgJY5KEL2d1d4jOSWteWMRDcF6TmPEvnELd/fOJuRuIzYgeIZ4lSX6p5VJlJ0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(39850400004)(396003)(86362001)(966005)(956004)(66946007)(6666004)(2616005)(5660300002)(38100700002)(83380400001)(38350700002)(16526019)(66556008)(16576012)(478600001)(8676002)(52116002)(36756003)(4326008)(316002)(31696002)(2906002)(54906003)(26005)(66476007)(53546011)(110136005)(6706004)(6486002)(186003)(31686004)(8936002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Nm5LNzN2WkQyRHEyUCsrLytGTDNCNytvTU01TkdvZ0lxQVBZMXN0bitSZ25t?=
 =?utf-8?B?eW1Ub1F3OSt6NGJ1YTUvcVp5Yis1L3RJaEdEZTRYK0lWZmRMSlJYWkErMzZr?=
 =?utf-8?B?UUplQWxiL0RqMXBqTG1jYVBWVXhXWGtJUDZidktWT3JraUplQ1RSMGxWL2FS?=
 =?utf-8?B?ZFpqTWlTcHNJNzZmTmVrc3BuMGN5NEZCSHBPTWFKR3ZVM0FvYnpEMWROeFdz?=
 =?utf-8?B?UVRzZlQwaWdJZ0V5YUdwZHYzVXljaVptV01jam14RjZjaitGR1NROXo5SXVM?=
 =?utf-8?B?VFRibDdyYkpMWkVSM1Y0QjM1N09qeDZFcWdzZjY3U0tWN0xybWtoRzRNQjI3?=
 =?utf-8?B?dVpmVks4aFl5MFY3UXhKWDkvbTg4Qit3LzVqeDFWTjVBUS9TQnVhUVZqUnpH?=
 =?utf-8?B?b0ExeUczS2xjWjZqRUtFSkZnd0k5TmRMZ0RhRFJQQTdHOGR0anFEdFo3cUUz?=
 =?utf-8?B?aXRoLy9TUlNIQ1BxeDVXQlhmeUY1OGlMdk1xUUZJQnBDQi96eW5DTEdqejRy?=
 =?utf-8?B?dzZ2WitubFRybCt6YmJkYmJFSzZnZW80VjltSURZZHphNVVEM25QajQ0a0VC?=
 =?utf-8?B?eGRScnd1OXVwNHJMOFYvOFRUMi9XdmlzRllBNXBaRW5SaEd0aEJEWVNMdUNi?=
 =?utf-8?B?M0pBbTJTWjFwQWhMTVZQSDJ6eW0wQUhBRmM4MmxyNjJGb1VDV2w4cGhNUG5t?=
 =?utf-8?B?c2NsZXNEK1pJNDl5Wm9tZ091dEUxVXZHc05hRityckwxTnBzbDNnT3hlcWd0?=
 =?utf-8?B?elorQkx3MStudmdlb09aTmpWRlByRlEzRURpR2k0NHFoMGdQdXhwdW9raHIv?=
 =?utf-8?B?ZGw4UmpuaytQSkg2cWs4am93c3JobHJHKytjek40Y0UyYVRZN1UrTWhZQ0k3?=
 =?utf-8?B?ZDlzWUg3b055ZDRpd2NaMW1UUk15UHpzQW4rYzFkM1lQSWNuMHlGR280aWg3?=
 =?utf-8?B?R1JBOFh6ZEd6K2RnWlkrcE1VT3U1QllXbi9xRjd2dnhZZXFlY3NGb3hxanpJ?=
 =?utf-8?B?Mk5DWENkUXE3dkhxQUZPa1pFcnNudXZleEZuN1JYcVNEcUhrY3dVM1JxZFhD?=
 =?utf-8?B?VDE1MzkyY0FBUWUvdUhmelFUL3hQSGx0TGdhL0I1RFFuZHoxRjhVM05rd2hi?=
 =?utf-8?B?SW1WdCtQT09aTG01U0VKNHd2MG90NmRRRVEwYlA5aUdMUEIrV0RNSjY1QVll?=
 =?utf-8?B?b091TjZKcjFnSG1rVG82RmlML0NnVjVmQk50bG5nUVdMM3h1dnYrVzh6Yy9D?=
 =?utf-8?B?a3JITnQ3OWloSDlObkk4Nkp4eFl3UFlVV0NDZGsvSUROcjc1OG1pdjNUVTU1?=
 =?utf-8?B?eEljQ0FFZGpOUDc2dUl4S0hVYlBaQTNIQklUa2pXUklrcVg0czg5VkZpaTFi?=
 =?utf-8?B?NjdMZisyazVPUVJxZ2JmYzFCYUZ2NzBoaFJiblM2SndMalRBK2dVUEVxZ0tI?=
 =?utf-8?B?QUtTTHdINmpTWGE0enp4T0ZEMGZLMmdqVEJnOEkyUVpMb2JVaW1yZ1dPMkNJ?=
 =?utf-8?B?RXNmd1ZvOFBadXJRSlRZMEZ4YUJJWElqL0xndVNhZFlpdThYSnlqdWJSa09p?=
 =?utf-8?B?cjFONThiT3ZHb0VEbDhHWEhjQ284SnBYNFk2eG00bGRmSUJwSEhOMm5GVU5h?=
 =?utf-8?B?ZTRpQnRjS2JCOWVQMFkyMENpVjZLR1kvTHVra2xaTkdQdW93VkFhMi9xLzZj?=
 =?utf-8?B?ejV0Nm5lWElrUlVzTi9zbUY5VXpYTDF2dXJkam9Xb09GZmdhOTVHVWovV1JP?=
 =?utf-8?Q?um5HLmV0MmSQhptIYbn5XJSTQsBPSAVeXf+7gax?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42d63a9-54d8-44df-f334-08d8fe71af4d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 11:45:50.0175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHJzgUf1UyGJErN93qBLtTiE7XCuIWqtDncJ6u4Mx9GAYtYaFCIMNTav06zHWV6rILLVdUBwY4spr5LqHy+khaCSoDrduvUhniBmgAQioR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1544
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dan,

On 4/13/21 6:50 PM, Dan Carpenter wrote:
> If the allocation fails then we need to drop the &xqspi->op_lock mutex
> before returning.
>
> Fixes: a0f65be6e880 ("spi: spi-zynqmp-gqspi: add mutex locking for exec_op")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/spi/spi-zynqmp-gqspi.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 9494da9aea40..d08ca6d5670c 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -965,8 +965,10 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
>   
>   	if (op->cmd.opcode) {
>   		tmpbuf = kzalloc(op->cmd.nbytes, GFP_KERNEL | GFP_DMA);
> -		if (!tmpbuf)
> -			return -ENOMEM;
> +		if (!tmpbuf) {
> +			err = -ENOMEM;
> +			goto return_err;
> +		}
>   		tmpbuf[0] = op->cmd.opcode;
>   		reinit_completion(&xqspi->data_completion);
>   		xqspi->txbuf = tmpbuf;

Thank you for your patch. But similar patch has been applied:

https://www.spinics.net/lists/arm-kernel/msg888807.html

Thanks,

Quanyang

