Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080CF3DE5CA
	for <lists+linux-spi@lfdr.de>; Tue,  3 Aug 2021 07:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhHCFC1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Aug 2021 01:02:27 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:18302 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229753AbhHCFC1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Aug 2021 01:02:27 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17350fbB025007;
        Mon, 2 Aug 2021 22:02:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Rn6TlduRhUOmj1e1I+kG5ykKTv4bcueobnmhNo+skws=;
 b=AcIBCB6BAATVkZR6WewmaiEK/DQaxYABIwl+PVoWtUoEu5qsYH6vEwcVBQAmyLH9O8zq
 J1YMlhCTx3j8wIYGcijGpcskWpdDQi0okOKtYFHQIJBBWPkiBmIPZZjCNvppbw3DD5zR
 s7jgO4fuZ++jUtUm9qIAb80epfmqQMvE3vGb6xdIOcL82+4xShwECpcMKc1KOOH9Rgsa
 7hRhrPBXZ0S33mT5uSa+ZKMCjc2VMtnYR4l8RPAetbiNs9GbI4U0P9hnN0np0GEZqLjL
 BDULR+Akp0WaOpsPBlWXw3CQU6fuIYFhqDM8kV6TdA2h+C2g20D9wSTgZl6JmFPK8ht9 JA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3a6k4xj35y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 22:02:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGpvTt5LCYzDru3cUX01C4ce8MSa5b7xDhmi15lBwVCuxvYbVQ3fsj4LGOurQBCB3UpoLrEYQRaTGHCQ5FlMmY4QcE1ep2OCPqvpGeNBctWM83DTfMn7c2BE+SAlhS0ipHZZHY3mpuskIg2PFu/vpDCi8xkCsLs5OVTlJi3s5U86QYRMY1viPWEcKZymBwIWGnBhWAIKHVwZjAVItAgkrWxOysH4Nzgpbqum6Z6s1vHjHlGaGqlu1p1sN/FcpGYzepR4laDjSP73yePzYxYuw1juvpl6eVCa0/k08aW6MY5pTWcElNGPhRtNNgdPlYFDIuaUnaLiyDYh3V9z/vZAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn6TlduRhUOmj1e1I+kG5ykKTv4bcueobnmhNo+skws=;
 b=RblFHcQV3YBH6mmQiSXdm5NYv24qQCrqxlK3ZUwv81NV9SnL1vh2E9dOTCCTzeCBW3ozHBpeGaKWz2lSBmiTQsl0vvNK093Bf+YnhOFtEuWK/3kmn/Xo1KTUK1IeF/yplZZoDoPMNy0zlBPuZQvhkV7po0WM5Xns1vXCtq0o92+RCNiph41+5fcYh94EHUSk/M9hzhf7bPJBWezgTk9N4HD1uXii2cT91xXnppJH7bNCG68CEPe2MUuSTc7YnI0lPd7dXTp83daFsN6jjL2uSrLbeTXejIHCahI0BDFNDu134OlUkD2gfaN9Ud1MJka7a7q7OyRCaJjOeLtHxCcSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn6TlduRhUOmj1e1I+kG5ykKTv4bcueobnmhNo+skws=;
 b=i9Yois7mYcQFPKCAnez38exXueM0Xu6tWQYFmn1HT/XAA4UaiIy2knHdiLF50Tl3xbTYQ8RuqYGxIooY4G/Kq7HV3KT27q3NVdddP2hG1LIKAN5jnXCTDehf64Ey5Ja4ocV9a0H9y/uYT2dJ67H0nl0yJ/Ayudo1SeVfVGfuppE=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR0701MB3812.namprd07.prod.outlook.com (2603:10b6:910:90::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Tue, 3 Aug
 2021 05:01:59 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::4925:985a:45b1:2672]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::4925:985a:45b1:2672%11]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 05:01:58 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lukas@wunner.de" <lukas@wunner.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>
Subject: RE: [PATCH v2 0/2] add support for Cadence's XSPI controller
Thread-Topic: [PATCH v2 0/2] add support for Cadence's XSPI controller
Thread-Index: AQHXfgglxDaMJYqJwU6Do0s90gbTBatgjKoAgAC/t7A=
Date:   Tue, 3 Aug 2021 05:01:58 +0000
Message-ID: <CY4PR07MB27575FF7D764BA3C20BE8850C1F09@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1626855118-25327-1-git-send-email-pthombar@cadence.com>
 <20210802173228.GM4668@sirena.org.uk>
In-Reply-To: <20210802173228.GM4668@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1lYjUxOTI1ZC1mNDE3LTExZWItODYzYS0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcZWI1MTkyNWYtZjQxNy0xMWViLTg2M2EtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSI2NDMiIHQ9IjEzMjcyNDQwNTE0NDQ5NTQxNCIgaD0iNGtKOEo2Y1dKYlpOcUswM2FqR2dMSHJUMHFJPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0608f32f-25a1-4046-ebd2-08d9563bd2d1
x-ms-traffictypediagnostic: CY4PR0701MB3812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0701MB38125BEFF337C7754C5A15D7C1F09@CY4PR0701MB3812.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SdClsW93WrbXnAVpZ1H/o9iQU+kbFHFjU6rOUimN7O8Wc1nKMqttEvlpU0WnAH7NmuYqc72EOGscuUpGhKPOh6O7PrlW2IfMcGB0oSE8bnPrxIFgkzIzZ73HWSGJJEtXB3amyirtmvWP7S9YP4nlHb3wxefDd/at/s++lYkBjpb8eg6vl9JrAJ2k7kG4b6eetwtN1M4RuI3tGbW047VGV1vFYExpCZMFkzXWccG3+SNSZ3Hz6hL1g5OWe01wfSIvjVLG0sAhyNP/SJpZOg62t7s/4ZXDnTdaPARw2gMwe7pNwqyEVJgvjQJ4KC393h9LpF1UuUw3I54cKnG45df48ZxiuexmEDo8nrcomWg4s+YA7E06XWYFkJpfd3P/qkgCDvAQhUxq5Is2wJpqD3FJdlthKbrQyWbkTa3PKXwm7K72apDlVnhbpiHcsKnmdZfSoBZCPgMZ0g71d1Z9BJ//f5InMYkR9dpD5s2q4hbVU1lrSldmOb+4XlqG6KNLFBq1XWLxnibxup9Ir2+OSEbSugafY8XqNLId5Deo4vwa8x7GtZSeeCQZq6noP08/13V8zuNQsgdtS28gnlZ6ub6CmqyWOGQ7FiSFAHSA9PgYM88T3rUdUxMiByuTlNHCIgr3KlV0m9vkpIZcpQqinI35YUCfNA0WqliAQMe5cvzAnK41fFOsgxaVhhvls9jhe0QJyo8fNnTOJVeIIJBk8Ze6hCrOfS8swctu2geol/axMvsnzSsHbNnTaZEWEEK948/8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(36092001)(316002)(66476007)(6916009)(7696005)(64756008)(66556008)(38070700005)(122000001)(66446008)(2906002)(66946007)(76116006)(38100700002)(55016002)(107886003)(71200400001)(6506007)(33656002)(4744005)(8676002)(478600001)(83380400001)(4326008)(8936002)(52536014)(186003)(5660300002)(54906003)(26005)(86362001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o28rekTFq8UIVMBHhuk1ijJJB/BvL4gszac3hITpEuzwbLL8H7ZO0jUZ41z3?=
 =?us-ascii?Q?R/DqOUHuKOPlypl9itymA/UKqxVQnLFmnTtTpvS7X7/1yPoT9Bct+qdqEe5Y?=
 =?us-ascii?Q?A88KW2hLMRekTnS4UbqM9lt5XEDVqUaqNCkFnlOxge77/+IV55Q/Pi9dFXBM?=
 =?us-ascii?Q?pMSkd31DFmvzLJ47WLRaC1u/tMvia/ZIA/WfrU7jQ3PVQ4n1SkEygA3ADd9/?=
 =?us-ascii?Q?kmGVKc47bLXmk8HjSNJB38ZCu2kCSfuR8V4hLyS6La+EHpFY+WaoGSxXuU+G?=
 =?us-ascii?Q?35Zpb3niZiZgR2SNgCZVYz5oQtkQsBOpv65LM4eDDx7NZlhQfJTNY6u3k80T?=
 =?us-ascii?Q?1nxXF9gzHp5qgQwpPmEvqyCZz7UCO/3AxcehhZ4+kz6HDH83jg5cWDS65Ige?=
 =?us-ascii?Q?KKk/yQUXbYp0eNuaRk7f6kAnM9LkrMNKCJgrXIRifK8dyGZACpNLXrUkg9xd?=
 =?us-ascii?Q?JuzX5mczTUYd01Yiz6zERp9G5wtgZ8Tf3Vhwh0J75OKsWHeYrwlI4WxNQxO1?=
 =?us-ascii?Q?Ck9NhKe5ZRUvos3Me9aFdFogDrc6UFD+0QYRPl2x193gXFkNnwPsgXsvOzSa?=
 =?us-ascii?Q?QCK3Ti9yZcacd6hCV0JxMcpJ219YG1lytJBZLHbF0Q9wT2GRS6f9kiLjmhFJ?=
 =?us-ascii?Q?PqxA7sL7DELYqs+Z86X+e4htgGYancC1AOiKS7tAvQdCXm69xulz6uz3QBpk?=
 =?us-ascii?Q?QXNwUELty3KA6kuS9ohvt9AjhDAowQf0QKG57FdX75SecdhkzH49OwArgjnj?=
 =?us-ascii?Q?Ak4K7Z0tv/fwLcvSe71REdXAZRou+d4G+UqdA5+dgN41q8+eQTgjSkNi3FC6?=
 =?us-ascii?Q?WHKnFTMDIWYDPpvdJRL3TUQYc1jdXX/SOvjNYSVv6M0hP38Z+4+tafHKUKDY?=
 =?us-ascii?Q?3uIAFF+YgiP8CHfS842BYyD84f2zwDXn7eXtty7l/FNT5n9vxstPPU4QjAwP?=
 =?us-ascii?Q?cNhcD9vFoV3jmosQ98EzvWTIAhAVszHZvIhH8I2NLCIQ3YfTfZNxHswjfbC6?=
 =?us-ascii?Q?OxQYjYh22+vHKU2+Ec9gG70Ku6mONiEBXAPjUg76A+AZTehoUogroh6s/nvs?=
 =?us-ascii?Q?lAVC2WDAGCds+mLipDhrzVP0fYW+1Ioubl+W2pFe5v//kkayXs1ZIbLTgxeT?=
 =?us-ascii?Q?y7IKJKVdQZoaRv8BXMTdY0/NuJVO1tmvntjR8AGbwBCllDqEozSpU3EhogaJ?=
 =?us-ascii?Q?qo2ojn5G23bl0B3mMWfMaY4lIJJFezWA9YR1mBpNtEOyFmmnvEK4Xu709+8Q?=
 =?us-ascii?Q?u7ZJ9LGVQCVpuDA6PlJaGn1uMIwAkXud6YV1KQOf2RgD6aVU1fGUSYRIBhd+?=
 =?us-ascii?Q?HvnTuKXSkdmtbj0HGoqpmAPD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0608f32f-25a1-4046-ebd2-08d9563bd2d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 05:01:58.7873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOdAb+HU0kSUI4VPF+Eyv6uxyqsKTWwX2U9af7BE8E6tN+hojPi4YjpPJVSTZXpPDMJcd5rL8QcceNbqwqmvlOCGAe9faXncB9ZawZrWMhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3812
X-Proofpoint-GUID: OZU7tGr8AVk6ur_TW_wZ73DDwQ_Eie-O
X-Proofpoint-ORIG-GUID: OZU7tGr8AVk6ur_TW_wZ73DDwQ_Eie-O
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_10:2021-08-02,2021-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=763
 phishscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030031
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

>As documented in submitting-patches.rst please send patches to the
>maintainers for the code you would like to change.  The normal kernel
>workflow is that people apply patches from their inboxes, if they aren't
>copied they are likely to not see the patch at all and it is much more
>difficult to apply patches.

Sorry, I missed you in last patch set. Pratyush has pointed out some
changes that will be done in v3. I will ensure to add you and other
reviewers/maintainers I missed in v2 patch set.

Regards,
Parshuram Thombare
