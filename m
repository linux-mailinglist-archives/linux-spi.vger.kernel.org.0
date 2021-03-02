Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0210F32A5E3
	for <lists+linux-spi@lfdr.de>; Tue,  2 Mar 2021 17:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446195AbhCBN15 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Mar 2021 08:27:57 -0500
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:22338
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1444939AbhCBMu5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Mar 2021 07:50:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uzlp+6V0EVxDwTgqu4b15qOtpdzyWXtnHAhesgXPachqy1m3Mbn8+o9/EJ7dlKgY5JDgw0KkJg0K7EMYXvRjtRHPZC4Yl+DnWfEXKl/NCJAK2jbugdgY2IK+i5lQAtw8LvxEbxYMJeiF4o435WcH0lSGKmVDkMGAIL18NTtXXAfy6xYxcciCr6Gbcsb+esfw+a2bHIeQRuWOh5DpjTCtgzn9lXKRD55M2hfNPaRc2vUUwJWVjXzLhEgs92apOLLN+iIP+kxvI9bRehgZD6VBnDK51aVEwjnpc8hdfnpRUP9mUh8hBl1q4NAyXR2TQhMePd5N7LHkuMFlQ5oKNlm1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnLYhdXqbeZnyVlItQDNzbKsOJ2hx2neEzyWk6PAdS4=;
 b=FmlKXFPJqTnaulF6Tc43UtrpJKNWl40apGbtOaI71+xI/M43eKTdm0mel6lVkASZUD4jqkacYjQanYI17uDA+k92v9TzZW9TLL/xLrssOhbFQmYOWRSO6iproHziLZjarnmHrfRJ5p0c7a9dh1JWQplNI7TGd5uFqc1bULsqEzjnc9K+6482o2vZCD4BKAJda4dIhptk8w7XGKiMroSPKBmdNkKayqMFkrn9m6QcQyaWOdsQTR+iQQ2CY2vKaoAXdaBSL0n5M4vC7bq/w5RFFIik82odKKI15Am9bv4SHmths8yqYPYJhjqpGF0OmdwFQaGjWSPD8UKBYROnQik7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnLYhdXqbeZnyVlItQDNzbKsOJ2hx2neEzyWk6PAdS4=;
 b=ripHzX6iq5T2mCEKi5u96LozbSkJzanHlUJkrVZml/Dkcnwo61hspR1TrPw9E9O1M6Tx+mWutruIdSTVlkYTK/5ej/34LvD0XlhQzZIsV02+xrreLrQsBbby3H/EJMvbyaaU6dC4tItDMM2X82d9/RSblmioZvFAF2+jl9gDrKg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB7PR04MB5083.eurprd04.prod.outlook.com (2603:10a6:10:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Tue, 2 Mar
 2021 12:50:08 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 12:50:08 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [Patch v2 0/4] NXP Flexspi driver patches
Date:   Tue,  2 Mar 2021 18:19:32 +0530
Message-Id: <20210302124936.1972546-1-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::28) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 12:50:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1159b3d-0dc7-4e63-392c-08d8dd79b575
X-MS-TrafficTypeDiagnostic: DB7PR04MB5083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB508364026156E27DF0CA21EEE0999@DB7PR04MB5083.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KVTghTPokJTWJbeAruIo6ia1jT3Sp+B6DMROmT9bDQs0B/05LNWIJBsAjyL5jr3W2/RiA0bwJ+EdhwPldqJn9kLLY/FT9ZADZdf91MM+g9lanhja0GX4DpN8+YLb7LYUd7uyx2t2sondwn+0jxpsrOJXlEexmbzFhLixuDrCgHYsQ9hdn3ICqxl3S9roe0ng3HZr3RZZQq9d/NaLY4BcuTcltfo7wT/CRzbIBcW8QoZV/+U6KZ6fboXTBa27XaAYO7M5F+crzjm5L4zEY1ETFsJ5TXK2ceRoWgXG6ia5HBgTW/J/XfwccUYjwq2gorK2rIWL6b9olnaid1+zEKSJEJROHXmQfcVjl4JPmkL7hQj88/aTpq7Iq/+7Yuc2Rt6bdgPMtanNkv/ljCqJsCPoD3tH/lGAgFmRwvxHokdD++dAWsBOFDq+4adXZH41SQUYXEo56Qmn94UdGYLu4Sl2S+hgiD9+1+/vwxfSZfqApwauj7RO5HFrluebLCH3G+IYZjNptGh/GBD0+Bt61Kv0U1WH06+HL5+jV/zi0+YDTXfi6XrFVXdPaMZAIM+8Pel4gNRmu4eI16fi/a096Sr57g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(346002)(366004)(136003)(86362001)(1006002)(6666004)(8676002)(316002)(4744005)(54906003)(5660300002)(83380400001)(1076003)(8936002)(2906002)(4326008)(478600001)(6486002)(2616005)(66946007)(36756003)(52116002)(7696005)(956004)(26005)(55236004)(66556008)(16526019)(186003)(44832011)(66476007)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dW00H3oH4pEVN6GNeM0geLZVMUvfOzUUvEPhBv7OvKX7fYFP/tZMJQpjcwyI?=
 =?us-ascii?Q?LKiP4q82ozdobAhrAvEFncdGXpBbYucSVrR6nGWlN81mVXjNUGWScdBjKYZJ?=
 =?us-ascii?Q?5sXDOjLdUd/rtAXCdQj65IK+FE4poyFdkI/iq/Ds3MW5Dbcl9t9oCb0HWx7B?=
 =?us-ascii?Q?+aQx6/s5EmYYam0eLsOOTRPQJ+2G0G7TEcmdqdeKjx8UHRSVYj2bTBKIACe8?=
 =?us-ascii?Q?3EVEbHgWxoXTX3YgGXVSig2upIlozAJyAs3Y0fxWFq4h4f8a+1HsaVTa6CDK?=
 =?us-ascii?Q?ANB7DOFFpH0vpYNR/G7u9CrAD3shgXLTm4M0tyS1aYn3NcJIStQaMvITakZ2?=
 =?us-ascii?Q?lKw+LEZA+9ygTpLSDkFpfZG0oRT9Mxb8CiB+UNmpAWmsV30aX10seVH/wQKR?=
 =?us-ascii?Q?JjeUDshVjlpKsch5Xxr/HJrRFL9Ox0Hf2aDhwHTbp4rPaepTX3ASOzlY9NEz?=
 =?us-ascii?Q?jDLEyqJn0R9GlqbFNmXVHLksAxoKyaXLgvAwDHkG3kIP4It8xUa1poZxW+OE?=
 =?us-ascii?Q?UFOq8yptbM4CaAkQHoQ36YJ7L/cp8TTc3bOQU5e+OoAnBFD8inT9W9k2j8Y7?=
 =?us-ascii?Q?GqoHOUalfkhHEXLRxRAmVwPB/NQ7zG7S9HPSpAE2iPormqzn6GbvEcmCqe2P?=
 =?us-ascii?Q?OxOaAmJX91oT7ARECszde05lE8WJ1VPYDHGv5lN+WPc6FBImXZJSFze+LgKN?=
 =?us-ascii?Q?r3/Jb6dTts95lHVypbHhO9U3zmVBdm5gODxuQ6EEP8XAtfA/arPFixZdvkGW?=
 =?us-ascii?Q?M/mDDZzBeTZjU/2gqxIdqR8xpRTUlkbmxyeBbDCFY/GPa5naOE56bbPwnzUI?=
 =?us-ascii?Q?i4PaaoEb8z5oP+RjRzO9qvHD5kv+SnaR1RQXYcvBYhCiDRPVjlscgWYeLibD?=
 =?us-ascii?Q?5HDbAIr6UwZcpRqtQp8rxC4AmSt6QoVV60dU88IGghadHnsJ8Mg9j3vfsHjC?=
 =?us-ascii?Q?ZRYm+Z6EwsM7rS91pz2BcTV97/pAYlZXLWsTBPDAcaJ0apkpdv/wtap8XUuu?=
 =?us-ascii?Q?6mFyi7vAiOMUPSxHKzojhKs8rH2YDf/9iJHQJe9IXS9r8pk0viBqjY8heh+T?=
 =?us-ascii?Q?vsXJ8UzKAK/J1iN5hvIPBwZ8hJIwsg4OGlEkghcTKZiF8KayC8AHIh3CIogq?=
 =?us-ascii?Q?HOtnRpcuQnHUjEB0SF18shrCHWjcrMa56zhNMEmUT23GkgnORqMR5DFqVbqy?=
 =?us-ascii?Q?Uz36AlVhVqhGA7rdnYqEBOVptVhV7czd9Px747mcqEou5u4Kq9blXQ8d5rju?=
 =?us-ascii?Q?9NKMBbJRN1mc46o2oEqF3T9NZi7Q/3XnNflsCBlTis8Mh4cbBeTO2dsF+DD6?=
 =?us-ascii?Q?Fb7q+RB04BrK8Vong/PxEV2q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1159b3d-0dc7-4e63-392c-08d8dd79b575
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 12:50:08.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ME4fsZQZkrzuRo/SwMY7c456FqiDLmQ682nFM+hC4xhM3/s7edYcLA5RJ21RS1dGwq4kxktU9bNMPtyEzDgdmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5083
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,
This patchset involves changes in NXP Flexspi driver.

Patch1 adds support for disabling AHB and enabling IP read only using a
quirk which is later used by patch3 and patch4.

Patch3 and Patch4 are not related to each and are rather dependent on
patch1 and that's why I kept them in series. This also helps in easy
application of series.

Patch1: Enables IP read in flexspi
Patch2: Do bindings document for imx8dxl
Patch3: Add imx8dxl driver support
Patch4: Errata workaround for LS1028A

v2:
- Add new patch for bindings document for imx8dxl

Han Xu (1):
  spi: spi-nxp-fspi: Add imx8dxl driver support

Kuldeep Singh (3):
  spi: spi-nxp-fspi: Add support for IP read only
  dt-bindings: spi: spi-nxp-fspi: Add imx8dxl support
  spi: spi-nxp-fspi: Implement errata workaround for LS1028A

 .../devicetree/bindings/spi/spi-nxp-fspi.txt  |   1 +
 drivers/spi/spi-nxp-fspi.c                    | 114 ++++++++++++++++--
 2 files changed, 104 insertions(+), 11 deletions(-)

-- 
2.25.1

