Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08202C3BD6
	for <lists+linux-spi@lfdr.de>; Wed, 25 Nov 2020 10:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgKYJTf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 04:19:35 -0500
Received: from mail-vi1eur05on2042.outbound.protection.outlook.com ([40.107.21.42]:34785
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726392AbgKYJTd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Nov 2020 04:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXHMHxqy/Gk4+9EJVZHCSjEmvwUx9ZejVbYp40eC8w0=;
 b=nLal1YvJpMLpD7iWoo7YRhQX41BF9mLEKtc3bBKNPFCRl4SUIyrXs1cmmETlWXiFFPgUP3LaY3RjX6Hz5Xz5O8Ow6PFRZ6eb4skEEsaK/180K4F2iqwrfya+1EfPyPjtg1kiG8T7EFFm2su9sHqS1hXhgmuZyuNwrvLn9Ua+oGA=
Received: from DB6P192CA0001.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::11) by
 AM6PR08MB4151.eurprd08.prod.outlook.com (2603:10a6:20b:a2::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20; Wed, 25 Nov 2020 09:19:29 +0000
Received: from DB5EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::50) by DB6P192CA0001.outlook.office365.com
 (2603:10a6:4:b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Wed, 25 Nov 2020 09:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT055.mail.protection.outlook.com (10.152.21.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Wed, 25 Nov 2020 09:19:28 +0000
Received: ("Tessian outbound 797fb8e1da56:v71"); Wed, 25 Nov 2020 09:19:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2e923c577d0e0cad
X-CR-MTA-TID: 64aa7808
Received: from ef1eaa489464.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 442E1BBD-1ED0-4578-819B-604375FB78E5.1;
        Wed, 25 Nov 2020 09:19:22 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ef1eaa489464.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 25 Nov 2020 09:19:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJE/Q1s7ssnWNbalQ9a4r+fTUwYRKhKOsjyUvUEC3aT5yvDzgtJs8LsEjtP05ZchPEE/BT6bI9DANgSEDg2PGZIQJEQWVxAMV9ss0M+aseJIAAtNM8Heu4TLdTwOTNRuVYLwoyifSIYXodOqMkS6uOyEfJ7H3zjNamrLp8eyBCTIKCfh0fG1CenB/AamMqNyvjkfsME5jzWPQvPd6mWaqTJyxvjJE803a0cdL3719WD+fIhhkqHc84CetA2jyFaL5PtTVkfFszoTI0JF08ryxDgTPsuXxMDqfE/kM9UcMI7MAzh4lLl5WU57dZWdUyAhRlTPp5kvlHHYOASM1bOQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXHMHxqy/Gk4+9EJVZHCSjEmvwUx9ZejVbYp40eC8w0=;
 b=cMlFh45eUJ6szOz7URjjjIAznmTlxwednhFDl/wG4GupxMHj2QT0HMDjInJwdfCCyfck7w1g5WwEKDVUUdrpaNeYRRYrKkOeoLanHvLdbPlOjvek/Tk2CECR2E2gB1+mIJk2KoTlZBHj0BglscMxXFO93S8u6+Qtaf39s/mKsueAUhfwM3RDxGpLIZUsrMyQgyX8112idDL0h0Ul4ECO3UMo0GpQndRIozp3wCpzrAj+A6qhnnd4q1PpRsZxVX8C6M4pCQabckXXOO32xD7AcLpN2pCuOZPI78TM1fQEvCmXwTmR5Whn46XFfQKF9TJq+6wwj7rQKL8eGQt8UUidZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXHMHxqy/Gk4+9EJVZHCSjEmvwUx9ZejVbYp40eC8w0=;
 b=nLal1YvJpMLpD7iWoo7YRhQX41BF9mLEKtc3bBKNPFCRl4SUIyrXs1cmmETlWXiFFPgUP3LaY3RjX6Hz5Xz5O8Ow6PFRZ6eb4skEEsaK/180K4F2iqwrfya+1EfPyPjtg1kiG8T7EFFm2su9sHqS1hXhgmuZyuNwrvLn9Ua+oGA=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (2603:10a6:10:ab::15)
 by DBAPR08MB5606.eurprd08.prod.outlook.com (2603:10a6:10:1a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 09:19:19 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::a998:af0e:17cb:9389]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::a998:af0e:17cb:9389%7]) with mapi id 15.20.3589.021; Wed, 25 Nov 2020
 09:19:19 +0000
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO
 descriptors
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
References: <20201106150706.29089-1-TheSven73@gmail.com>
 <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
 <CAGngYiVu3cXtzb5PaoDOoyqjuuohLQ+em6Keg-qgDFFn2tdp=Q@mail.gmail.com>
 <CACRpkdagAK1X6FT=sug5FGA1iipXnOT_ujtMBh9cVnep_DpWyA@mail.gmail.com>
 <20201111123327.GB4847@sirena.org.uk>
 <CACRpkdZW3G48Yj3yGMTKZGwVEQOSs1VeVTTGLgyoJViM3=Yedg@mail.gmail.com>
 <20201116210632.GJ4739@sirena.org.uk>
 <CACRpkdayWzWKHv69cg_GL2O=NWozqi_ZLnH1WdMOHzEb1bU-xA@mail.gmail.com>
 <20201118114049.GA4827@sirena.org.uk>
From:   Grant Likely <grant.likely@arm.com>
Message-ID: <9c7aee21-0d08-9092-acdd-93477ed17dba@arm.com>
Date:   Wed, 25 Nov 2020 09:19:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20201118114049.GA4827@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.196.85.203]
X-ClientProxiedBy: LNXP265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::30) To DB8PR08MB4010.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.16.178] (94.196.85.203) by LNXP265CA0090.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 09:19:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4ec06fe-09ff-4312-e63b-08d891233620
X-MS-TrafficTypeDiagnostic: DBAPR08MB5606:|AM6PR08MB4151:
X-Microsoft-Antispam-PRVS: <AM6PR08MB41510E0543D219C43E1FF93195FA0@AM6PR08MB4151.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QJQ6mOEgzEVDDD9IuWgkz+nlvgROFdHW485a+ROL9u4uewmyQwbnsW4A69FPNL5jB22PXEUb9USlZ3OMHDi6jL0+jUF6tIf77Oqh3CrbHp4dYcftElTBGFn6tcD3wxQCGtf3Lk1O5eBJPKlv5v1Gq9zs4aLc6oOtWNKTyJqAg/05qcSYStVDKp2sTlnb9dnKg8MYejsNSH0q7syjrQjfGTLSWZWFvtupy0V8Iq5W/mb6kzyxctFnHWVv4ntmPtK9CAKHRvx2Dtw1/iEBlRybFFKaxrd2+hDRjnOhueCwO9nHqRcJxAXBwvioTcdFiz+8aUOLVQxPV9l9iWu3wmFL7G+lSwRFRDP5ghbh32ZjKxT0N4QNvutqVqizjOJFQRDbDUj41tXmg+vBkTAsVpicODyD5a/6c0Hi1WrBTKSkp/pW6woEoeZ1RZVQJbmnHT6H5hw11soTRxM9YeJzRMPLzA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB4010.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39850400004)(396003)(366004)(186003)(52116002)(44832011)(86362001)(54906003)(2616005)(4326008)(956004)(16526019)(26005)(31686004)(316002)(110136005)(2906002)(55236004)(16576012)(6486002)(66476007)(478600001)(8676002)(5660300002)(53546011)(36756003)(66946007)(966005)(8936002)(31696002)(66556008)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sirBLjUcYQCIy0RLX6ehCyoIKMpCPZEBN1Ogy4JNbIYitNZ+NbPU2Q1N3Hl7hn6WElrE0kQeTy+NEqgOMGT1x83XVnCAyvr7Y2YTxB5P1DYRhBIaDOexwnrzU3l1xiEzGkhoF6G7h1HlHgIbaKgBZpDL75XhW+iRHBcsn3EIwuvjCF45kFHiS6XCKokH+jwedWmwW6EtvF5gzIEdCWqyvBpfycQZPusRevvbe6K003As6b8bMOpj7fLCHknidHChQsAW6h3jFHTuoy8Y8lob1jVcVfEK9OKy044G3JYUcngkNpAt6k8KGU5GokTwv/h04f7kcppcOp6kTfInqEBDmmWKwvTt1K6H3Mc3f+9qQSVhwAR7veNrmwsCklsmi5KnN1rU3ZSFLgSWdRt8S/Slzsn78qGYS9WuZws7zbTwrozqAXwLHXHDWhjzAPjNWn373NBGrfdJd3wcUjZIXP6nvqUTikUJB3mhO0CbUw6JcAG749X8zk6KpN9rz4YpA/cSvEb1ODSptTPydsmNb7a9RQ5+5sdhBJiLgVaMwxrGYFrMFhbzVXxCgVWkaiTzsmgRDYKgFA5+y8CxwQaiRqRk93YhXhHgeNNYa8RU7KZavvaEz/oYuCF/VZffCqJldwvwRTyp9MRcMp0wHjOOiy6K+c7eofK2N4adWQxQi3Z6F8J/chrMon2vRwY4ZZBRaRClrm0iXPRkGtbL44Y7j21HnuFhRvb9MEQokB/0jZAnEZp4QezmScNEnqdjw4/vSHqnNWDLbhpF8EbF+DZNt7LMj3bK7IjK/qiuTdpSpZIjh2z6SB2NpQYpT8DO4cnH5oE0NcUwRxDOdydSMfWUQ2Fwz3ewQRs4woRqWZV+85Os66bSObZ1c3ZebWoPChKDp3OV42+ZVdw8DML1ESWIn99cZQ==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5606
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: dd8376d4-a914-4d8c-f2f5-08d891232ff9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIF01MD3gjJ4R4oCiNsLIBaeUyVWG2MR2dJis5lK8W+hpGkxZt8ZEJTGD8GI1oy3+nc7J6/O/lO08WfWcIc9E00catlbnZwpu8M1NC70HY2FbYtun2mlealGeReKg+9eszZjWJ/3Q9w8vieaAW2kndi+UrT25mTJeDqMCWC58cJl/ShxWf5cbRkYMGiuBPymUn9t7L8Bqka/LaWFrxDKx7zS3/7+oS+382S1vrdAp/Y6gDi194jFxygn9LBeJRVTVvTUcGKsS5GGDjLmwaCZJPnmUobKLdxEY+TBqpkTGSLxFO8gcpLNEocSVtwRDP1U/cXA55qjkErC6xVl4YMLed1ffMwUwSWM4oCZDGUNNfC6gMpQ7dvt5/hNIvwIbrK204K0hnySanxx8DXaDmoQV70BdHtw8DmUmoY8ATzAo1NUUVzEfr4+BwZICkPVTmxU/DJBaGk4LCHQpiPSqsCHsVzq707dNj5ELNFb1fJ/fnYT3xxnTwbP3AwDSknQ+wL3
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966005)(110136005)(70206006)(16576012)(966005)(336012)(356005)(36756003)(53546011)(55236004)(54906003)(70586007)(82740400003)(16526019)(2906002)(81166007)(47076004)(186003)(8676002)(8936002)(4326008)(956004)(26005)(44832011)(2616005)(478600001)(450100002)(5660300002)(6486002)(31686004)(86362001)(316002)(31696002)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 09:19:28.9924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ec06fe-09ff-4312-e63b-08d891233620
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4151
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 18/11/2020 11:40, Mark Brown wrote:
> On Wed, Nov 18, 2020 at 02:03:41AM +0100, Linus Walleij wrote:
>> On Mon, Nov 16, 2020 at 10:06 PM Mark Brown <broonie@kernel.org> wrote:
> 
>>> I think the main push in the other direction has always been people who
>>> want to not have to write a driver at all and put absolutely everything
>>> into DT which has scaling issues :/
> 
>> What I can't understand is what gave them that idea.
> 
>> This thing looks like a dream to these people for example:
>> https://gist.github.com/Minecrell/56c2b20118ba00a9723f0785301bc5ec#file-dsi_panel_s6e88a0_ams452ef01_qhd_octa_video-dtsi
>> And it looks like a nightmare to me.
> 
>> (There is even a tool to convert this description into a proper display
>> driver now.)
> 
>> It just seems to be one of those golden hammer things: everything
>> start to look like nails.
> 
> What people think they were sold was the idea that they shouldn't have
> to write driver code or upstream things, something with more AML like
> capabilities (not realising that AML works partly because ACPI hugely
> constrains system design).

And is also untrue. AML only provides an API abstraction for a specific 
power management model. All the actual driving of the device still 
requires driver code and requires reading devices-specific properties 
out of the ACPI node.

g.

