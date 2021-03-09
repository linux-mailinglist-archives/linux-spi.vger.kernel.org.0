Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BED8332444
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 12:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCILmV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 06:42:21 -0500
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:27013
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229799AbhCILly (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Mar 2021 06:41:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coSR4QBEds1yM8AOLZJQWya0b6wTWc2tMthvFhiJydg8ML9rumhDRRlASxCSRMrlalnC7TMKbolf3MIcKHtIGncTK3ErEG19iYmTzPEkUvT9RnmMj1cnJ8xJL1eZkrV7fGmNOIX83+lHknz6POqcaOcw164rx1wHQX5YHDqnsMOhvZE34UDgPFG6RrFY3xzN58iap9lBsC0cEfcVgZcBK5D+1F+eWnkM+Y3VwwEi5xCdVbcCIlS09Ccy0Kz8d+esnz6O3Ga46m9gMJ2+jS2uaR8FlK2bUTB+gSs4nVm3wOS1bG44MeNsjHRfROPyx6Zu6e4wsSjsOimG4u208OGnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z93+rYu2KUthLpiADreP9SWsyJBwPBCHY6Wj5plhV8=;
 b=eDES/Egp8mmHH1pgHhHQbThZp+uT8Nxtb/EIOeYD9syrpG/EuQ39Sk5tLJWdKBnl4k2gRzL1zvYblBpu62+Sv/roMHDlWOo8nSg4mDYe/Npakn9ahzUN9X7tor9+WBsFk6m9D5/4BvrhY8fzB7UpePfBOrbj8SsXB0BSxrnqx80hpPvxpktGqeEOMIzcu6UFpvKh3sx4wDlYffBrG5STjgVWPaAPMd1BwUZtpJhO/AA9TAfkf8fSNqKFEqYo6LzBolu9q6LN+W4pAtsL57j4QfLEswBIr2OM1gS4UDeLhhPlJlk3rQDhzVM/xS+IhR+dlnxxmml7VzfX7Gw54s+IKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z93+rYu2KUthLpiADreP9SWsyJBwPBCHY6Wj5plhV8=;
 b=AnrHfBTIb6IKEHsv3bySN63PkbeIriiIGZ526/hvWfjFk0fwh30BFBYasusZE9AsIJ3xUY0the4TkaHOqzARovoTDi7iwWltHbw4Qwz46l/6aRcAGKz2akT8SI1eTwS8cvgJ3bkgHIrnt0i7YAYPhmSXRrZnoGyMschCQF8y81E=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB7PR04MB5241.eurprd04.prod.outlook.com (2603:10a6:10:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 11:41:50 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.037; Tue, 9 Mar 2021
 11:41:50 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
CC:     Ashish Kumar <ashish.kumar@nxp.com>
Subject: RE: [PATCH] dt-bindings: spi: Convert NXP flexspi to json schema
Thread-Topic: [PATCH] dt-bindings: spi: Convert NXP flexspi to json schema
Thread-Index: AQHXFM/6iIqk6EfgdU6QexJiEf5Gy6p7hhTA
Date:   Tue, 9 Mar 2021 11:41:50 +0000
Message-ID: <DB6PR0402MB275834FAF7CEF44AB7F342B2E0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <20210309103528.3538910-1-kuldeep.singh@nxp.com>
In-Reply-To: <20210309103528.3538910-1-kuldeep.singh@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [27.58.231.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41681f8a-9c56-4597-7f14-08d8e2f05462
x-ms-traffictypediagnostic: DB7PR04MB5241:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5241E2F81F57D44274CF29AFE0929@DB7PR04MB5241.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VRMuPUNd7D446wjzk3Hv9VZYM09bvTapZJp5/Ss0WXRtwCIb+dMlDdqgqqTAWouEPN+DOeHJzt9ZLPtMka+55TkSyZvPzFF45m0jrd8VRjwFK7jIxT606hlpT7znSxvjWH1jv41tZmkt4nr17ylvrtQk6jChZ2SafohheXwQiYRlRgtsEVNQOIPjGqYyKHWzJ2ij/qEKQWzayMdEyww1uIfygByWhtRHmfORiQ9j5Rme8HpBxtaZpQhurcN5MKdA2YkYRpUG72pg3XqVQfLyBVCkwMT/it8aOPflv4Bp6VrYrMBS/NNUAHDNJbt92oPxNcpg/rNO0gL5H1ZlEv27a9Pwa4EtUoVSrBl6Kk+4oWakHm+axLCE1lDinMjLlZAm8ClzeIjFnjdT6y1VrQBC+uAnrMaYrYGT27/ZpCL7zUvrEw15HfC0UUxjzd7EcalBEu2oWzxnlvFiDKR040mBvpPtke1rw7dPFM/x4B2hopwEhwZHghsuQ/Sme6ubR71L5E7RbxbzFMrYKk0o4WMn3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(26005)(4326008)(55016002)(52536014)(4744005)(5660300002)(83380400001)(9686003)(64756008)(66476007)(66446008)(76116006)(66556008)(66946007)(8676002)(44832011)(33656002)(478600001)(8936002)(316002)(86362001)(110136005)(7696005)(71200400001)(53546011)(186003)(6506007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+iqyJ1pqZp+E+04oCsAyAtomqR27xde/7wa+o6YC5iWq4mEo9S+vChFPXRfH?=
 =?us-ascii?Q?Ksq8Az6Ow0EZ59DYwecwJSckOeBdVgzoSnq391rd4Bss1vDxVn7KQ3JwUHZA?=
 =?us-ascii?Q?y/ZYJcLETnJGWxuOhzmKJqvO+QFq8mydhaFaEvAj+MZ9SC0IEVcMZlpYTZJ7?=
 =?us-ascii?Q?ryizcchwIQB5PKQL/Dp/pSYRNLm8+oVqoAsgRsFNPecF4/vmxU3LxSMy8gfL?=
 =?us-ascii?Q?bZy2y+sVTqaOXzMOjxYO1NJPGXZr2H/xp0GuQjWVkql6jl9H/sLSs/9fg3bQ?=
 =?us-ascii?Q?6J+I4Htv9FLqhlPpZA+C6Jfpr22w74VZ9MpwSPsGzfVXsgUmK3j9mozpLh1/?=
 =?us-ascii?Q?+XUnx4oQsqLoWI38bVRL+2Tq9pmGoDF+89WA7mq6PPWDOhvVcvTXmreH+sMb?=
 =?us-ascii?Q?eOGjaSuo8hf+ARydIObXJGneBTRv7dZwZ/eTnSt8+qjbmh5rOga/9yfE0tDv?=
 =?us-ascii?Q?jyVoPXkxtAqKVUH75feoHLdfBjSsMnyPcolyKa5DadNMCCDaV/RGu3tjonK+?=
 =?us-ascii?Q?MmAsXmSP3H+iEFAujocdxjmuh/+t7rRhfE7zYp49RkRjvfQ6kOEyKm6aG07F?=
 =?us-ascii?Q?ph3ViMonlaG6CpSAoc54w+r3sAH6rwtz8jR2j/li6iayFcDSdAgCPQ1ABNWE?=
 =?us-ascii?Q?lacy6dFMwF2i05TU3SGVghGFC8D5DgmU7nmC6NkNIuynhmZsgtM86Aix7KyQ?=
 =?us-ascii?Q?Zqq2zxULRKASYUos5VymNsoF+ClfqqHeW0FV+a5GS4KEkuhqDGhOaWkorkZw?=
 =?us-ascii?Q?U6BrupaxkjC5gKqq1MVewO0cZP8aDtAuGNWuhRb3vwmoOnQMhaQ3v/wbDIKp?=
 =?us-ascii?Q?85tdB7KOh5rM/V89DO4z+UVKfY0KVferSV6Fzec1cdc2N57jyqjTf8eTXIxb?=
 =?us-ascii?Q?t1SqCDFqSU8oHZTd41gZl36mYaXmnxJIcimmjxQw2xMqEZENMfw1JZTO2+o7?=
 =?us-ascii?Q?hUkNcOclFN8hLdyzHExnU66uun3QYQOA3ihO6/pfleyPCwMGIGj5I/Rx0tof?=
 =?us-ascii?Q?yvrRp94b/uJtXyc/EG4+/OywlUtmgTZNOzOHVsl9cbF1aZQS2B8BLUWDlQgc?=
 =?us-ascii?Q?UY3wjGIAzUfIMiRbzFnNUuXdxJd2qyRgTo5q3ZEeQnT3V4qhZoQQG4PYmaSB?=
 =?us-ascii?Q?U4BVoFXTIalxtKNFJRn9k4pAN9hqL900F1WGmLAtCzCdGq1yKlqjX8Ckh1UW?=
 =?us-ascii?Q?5IVvGIeUZqiltgq9HZII7695HnsXd5VeFa4g2QBdw594YkXSC4J/4juHHMSZ?=
 =?us-ascii?Q?QK1+iVUCnm6lDp4HCbFUwzAhgrhGSkpkV4/yFGxVBoykEOwqEPkzt3Bqldam?=
 =?us-ascii?Q?+b0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41681f8a-9c56-4597-7f14-08d8e2f05462
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 11:41:50.7695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /i13d67iSoZ8cjHsP4R8UzDshkUf3rqQWCQVqTAHYcUhXkZVNLhMrPUmi42StWvMBC96sYWuNc6/lLPtm1fTQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5241
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

+ Mark (Forgot to add him previously)

> -----Original Message-----
> From: Kuldeep Singh <kuldeep.singh@nxp.com>
> Sent: Tuesday, March 9, 2021 4:05 PM
> To: Rob Herring <robh+dt@kernel.org>; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Ashish Kumar <ashish.kumar@nxp.com>; Kuldeep Singh
> <kuldeep.singh@nxp.com>
> Subject: [PATCH] dt-bindings: spi: Convert NXP flexspi to json schema
>=20
> Convert the NXP FlexSPI binding to DT schema format using json-schema.
>=20
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
>=20

Hi Rob and Mark,
I was not sure with which tree this patch will go through.
Currently, I have rebased this on top of tree(git://git.kernel.org/pub/scm/=
linux/kernel/git/broonie/spi.git, branch: for-next)

Regards
Kuldeep
