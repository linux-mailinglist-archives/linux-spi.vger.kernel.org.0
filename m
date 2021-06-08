Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688BD39F6DB
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 14:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhFHMhL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 08:37:11 -0400
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:18477
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232579AbhFHMhK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Jun 2021 08:37:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgtp3w08GaNz9k/TSMXGedlSpU2UvvYpiFaii7NuWaEf7Xmx8/UomzZPgayxCBNS8G0OiI0jHHw9AibTr/SRtYabt96hD6q5hVjxQj+BTtFenX8HhRzbIG4JSUQgjUiO0jyBl8TXEQNDsFgTjsQ3EDIVsqEa7I8tFPkTPTOpuSVAiinCCkt/5N+wPHnjtj/OclXNuR0R4aYKlvaw+jX5wH6Y6Wskicu/1kjZ/Ky8se/Vg/ZaU/aWsADGDxNKitzbC2YLyOULtXlj7QCOfQhPTCsIMAnZ3pIlNC+G9MWoW2I/eZeJc7bHP5aZfGrlzUjAnP5NV2wW3HwQtiwO7iRkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caIFYdg/XlDIOWZEbpy9sp+/q4cU+o0doceqFZs9aZQ=;
 b=DJDgRocPno9czBsc48roZTn4Z1JrT+0XYzftoxi9dzDNUbTAmkwBs4dz9/+oz+XF/ZBVHFJa6dumdvypHDj8aZ02MN3gs4NgHKzmNDM3QtuY29bFJDgBjqZ0+p5aKhQiyt0TLe3Ky0+U9GLxRlt8bGmUMLB4wFEw8jtIACl6Fwy3K+ySaexhtYfi6WmHaaRmWam+BM0Z+7mpR+bHemIypU1xQegmFNk/Gx5mnr/7wKc3cSV7R4QQVy1hEEG4TN2yWRKpeKBG3+6B3SEXREsZBN+9tncA5SUfivDIlaAt4mrO8tEUd9Kb6+my9J1LpT0SS6oiv733mB228zPysI+j2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caIFYdg/XlDIOWZEbpy9sp+/q4cU+o0doceqFZs9aZQ=;
 b=KzgAw7nPHHBIh+cd1/4uhhCufKOkanegQQjyY4K1ziBSnK9RE6bRfRc/RdyL//jDlLfzfKRXdklqGui23Jyr3f2fSTjXnaHAWX3B/etsjYdKleR5gsKm6d62lDMgmEnlDnn73dlgk9B/oHBd6gYTmqAW7G2C3NKStOX79eSYJPpy0HkOWSDTLxFDPmF5JqWN9RGVVYDcOats4cPGWOnx3eqeNi8k1NQX0PYJsgdnaXDU0YoZaKqvcUa8og9IgQHOlbe5XGGu0zhDzwpeNbd7MSpGnemgHht6nmNrbcL5ZtN17bIWVKcI7D82GdbfqvK/Yu6LmbU1JcnHfEDcVSzVIA==
Received: from BN9PR03CA0593.namprd03.prod.outlook.com (2603:10b6:408:10d::28)
 by MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 12:35:16 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::31) by BN9PR03CA0593.outlook.office365.com
 (2603:10b6:408:10d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 8 Jun 2021 12:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 12:35:16 +0000
Received: from [10.26.49.10] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 12:35:14 +0000
Subject: Re: [PATCH] spi: tegra20-slink: Ensure SPI controller reset is
 deasserted
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20210608071518.93037-1-jonathanh@nvidia.com>
 <YL9eI8L32Tc8G7uF@orome.fritz.box>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7b4707f7-b895-9e98-c92e-d1e10b11c3f7@nvidia.com>
Date:   Tue, 8 Jun 2021 13:35:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL9eI8L32Tc8G7uF@orome.fritz.box>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e75ffa25-8bf1-4497-4681-08d92a79dee1
X-MS-TrafficTypeDiagnostic: MN2PR12MB2896:
X-Microsoft-Antispam-PRVS: <MN2PR12MB28969E979CB740C7C169DAEFD9379@MN2PR12MB2896.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVpQw1HcAT+wJZJtdz9bBlqVXQK+syKRoLiedQeSheyGeABRNnCqXuRRDblStdfobPe8AE0cDMSFWRpwaRqBmpZhONSGGS0URo9MhMUvs/AEiitZwHERgUX+IB7CQOQXPH1EP8ST4WA4cPBsnDnSb8PUG+P3rD+umpfYzQ4qhb35EFiCYBEEyDqthRvMql1plKtrzXdaktTvxJ4FgM+2klVueFPDA5qWgALM8R/z2XB58376QrEqI37PMohWbMAbRRRQYricVnuOscMkTqJHLfStf18xuYx51694YdnA3gNmKZ6wmMa64ItnXI56Tb2PM0gTQdxUr6gkh7PkSxEu8HJ19LUAa3xhzRskw894nSU60drrpKkuky8gy6JhjbKurdUCPPRAsGXYaoFc7P6AL5K+yYtsBEttcCVNwQsKy8Vpk4+hDHg5w+pYq4WjsbhTmWdsYH1wM2ederxbvaswELS3ihmLEKs72IXq+lhOC4O8/XPE31Ekee0PAZO/VVvABzHU+8uhbmxFgzq832mPfX4JsPEfrkQMhiBAfPkRPbI9yd84HDBd/gu2l/kxtZEAEtKIEeE9QdHo1hRCmax8vvFT3ZQ69cVEJ5OEG9lZc+TgxwYqSXP5QMbRknEPq658r75cfi97R/tMQx9W4K4xK9Ht0R6fuK3A2J5moLeLahe1bQWjopHkvlubAZX6R0Tz
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(36840700001)(46966006)(83380400001)(36906005)(6666004)(2906002)(4326008)(7636003)(31686004)(16526019)(316002)(356005)(16576012)(82740400003)(54906003)(53546011)(5660300002)(36756003)(2616005)(82310400003)(31696002)(36860700001)(426003)(336012)(8936002)(86362001)(478600001)(8676002)(70586007)(70206006)(26005)(6916009)(186003)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 12:35:16.6561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e75ffa25-8bf1-4497-4681-08d92a79dee1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2896
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 08/06/2021 13:10, Thierry Reding wrote:
> On Tue, Jun 08, 2021 at 08:15:18AM +0100, Jon Hunter wrote:
>> Commit 4782c0a5dd88 ("clk: tegra: Don't deassert reset on enabling
>> clocks") removed some legacy code for handling resets on Tegra from
>> within the Tegra clock code. This exposed an issue in the Tegra20 slink
>> driver where the SPI controller reset was not being deasserted as needed
>> during probe. This is causing the Tegra30 Cardhu platform to hang on
>> boot. Fix this by ensuring the SPI controller reset is deasserted during
>> probe.
>>
>> Fixes: 4782c0a5dd88 ("clk: tegra: Don't deassert reset on enabling clocks")
> 
> While it technically fixes an issue uncovered by that patch, I would
> argue that the underlying issue has been present forever. So I think
> this should be applied regardless of the above patch.

Yes that is true and there is no dependency per-se but wanted to
highlight that up until that patch there were no issues.

> It also makes me wonder if we shouldn't drop the clock patch for now to
> unbreak things and avoid having to model complicated dependencies to
> make sure everything continues to work in v5.14-rc1.

Yes but I guess we will need to revert that one now as it is part of the
pull request you sent. However, that is fine with me.

> Unless perhaps if Mark applies this for v5.13, then we can merge the
> clock patch for v5.14-rc1 since SPI is the only IP that seems to be
> broken by that change.

Yes that works too.

>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/spi/spi-tegra20-slink.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
>> index f7c832fd4003..6a726c95ac7a 100644
>> --- a/drivers/spi/spi-tegra20-slink.c
>> +++ b/drivers/spi/spi-tegra20-slink.c
>> @@ -1118,6 +1118,11 @@ static int tegra_slink_probe(struct platform_device *pdev)
>>  		pm_runtime_put_noidle(&pdev->dev);
>>  		goto exit_pm_disable;
>>  	}
>> +
>> +	reset_control_assert(tspi->rst);
>> +	udelay(2);
>> +	reset_control_deassert(tspi->rst);
>> +
> 
> I wonder if this doesn't break now again on suspend/resume. Should we
> perhaps move this into tegra_slink_runtime_resume()? Or better yet, move
> the reset_control_assert() into tegra_slink_runtime_suspend() and the
> reset_control_deassert() into tegra_slink_runtime_resume(). That should
> ensure the device's reset is always deasserted when runtime resumed.

So we do test suspend/resume on Cardhu and I have seen no issues with
this applied. At first I did put this in the runtime_suspend/resume
handlers, but then looking at what is done in spi-tegra114.c it appears
we just do this on probe. See ...

commit 019194933339b3e9b486639c8cb3692020844d65
Author: Sowjanya Komatineni <skomatineni@nvidia.com>
Date:   Tue Mar 26 22:56:32 2019 -0700

    spi: tegra114: reset controller on probe

I guess moving it to the runtime_suspend/resume handlers would be more
consistent with the previous code. What do you think?

Jon

-- 
nvpublic
