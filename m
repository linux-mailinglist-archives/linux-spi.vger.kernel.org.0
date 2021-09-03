Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104833FFB82
	for <lists+linux-spi@lfdr.de>; Fri,  3 Sep 2021 10:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348196AbhICIFM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Sep 2021 04:05:12 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:21392 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348123AbhICIEi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Sep 2021 04:04:38 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18362gxa022119;
        Fri, 3 Sep 2021 01:03:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=YJfW0hLeE+hlnAWgnkeM++DaS4quyJUVWb4cqXtqPZY=;
 b=UtdUW4nwcLmw82JIOAzJFN1+qBQFZdBe7KZRl+Kir5sup9UF1OTGylTvI09qlLonU4dp
 CaUw0t74FugQvU+AEvf1AEwQl0QWxUntSr4KDz3dYzTPJ4TuqUiBy2rUjFYMKya8Vv3/
 IRTg0z9YYJnXxkedBJ3KsBA6YokunGjHDHgm4GThJCJE/+tlg/z6imD15mbkcUZIblJV
 F/jZ9kgnn2PVKANMvrCEVNGsOL5rH7gZaX0z2dDzVBNrgWmrAacd6rCVW7JhL0vDzSsc
 aLdfTUZ5B0sgHOPhGAPaZ1GtVpa992YyWHFmy0SVQBPJj/2qXqH5yZYeSSbh35TJhBDd EA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3aue3e0c2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 01:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/eaIl+GrjMcyhR9BeRdR14OhCtzryqCwInfggGb0+8yl95dt2wlEsnJOb8Tuh5UdUipKMhkVZH01WDqNNrbQY24IZ28Djt5NL9Km9u3rLeMD/DEEHZ11Bh4jBvvKf7H4INiBoto28xzCm3ERcSGAmtCP8gVjsc1UXXEt1SaZarIk7fmcmvekgq0VROQevLEzhOslICOQJ/d4BPnJYZz+Xow0MSCdI/qZma45ZY1b/xYwhzHBqZCz05vbKnAKz0vff8HACKox82SWWE1XDcEJm7YIX5s9u7YQ4HKvoPIoxSr7rpXdRrVEV4rwtJG+qvCfoKiE1drPsdvrrvNB6rtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJfW0hLeE+hlnAWgnkeM++DaS4quyJUVWb4cqXtqPZY=;
 b=NlRx9LCac+BVk8UtxUPLDPtsN0/hjO8r1XQKcqtsxw50h4Y61nhI8L0egFWgyd60LMtHW66ThPXbOpf7mTbCcGAKWodEgHS6Wcc1bDet3AZs+7hXM+6mbT8lNHgxgikSdb1jnp58cAEf64RenupLz2CbEzQ55bb/u3qUdYBVGO3UW2zLEZCGhW+Q4SMnhvnyK4sGvftCzf1vFOpkzxHX5V9wFN0EiwQJ7r5HkaZI+vT9tKgKaQW69aqGazzaTPyEZVE5sqkRluhVdY1QnoyxHK4Tr1EC7m0m7qeCCKbq/P+yFHwfvff0e4i5c8yQa/KgI6H2GYyGKEyjEhexttSXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJfW0hLeE+hlnAWgnkeM++DaS4quyJUVWb4cqXtqPZY=;
 b=hgXjh3MrIdVSoxreMrrrZ6mbQAMMCGfbpL1edlH455pXb++3/kuEOZ+V38JSSFLCAu77L9mGmILEIERXzO1qutJywXeBMjC4P8J7aiHGxeuu7AZ1Ym7EP7zvyBmFc8XXvGlYSigClAIDaNgrtE118mN48pe7GXyPsYAQXpFK33s=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR07MB2967.namprd07.prod.outlook.com (2603:10b6:903:2a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 3 Sep
 2021 08:03:08 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87%3]) with mapi id 15.20.4478.021; Fri, 3 Sep 2021
 08:03:07 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "p.yadav@ti.com" <p.yadav@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Konrad Kociolek <konrad@cadence.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] spi: cadence: add dt-bindings documentation for
 Cadence XSPI controller
Thread-Topic: [PATCH v3 1/2] spi: cadence: add dt-bindings documentation for
 Cadence XSPI controller
Thread-Index: AQHXny4YIjHh85hURU26SR02kFfey6uQpt2AgAFOVDA=
Date:   Fri, 3 Sep 2021 08:03:07 +0000
Message-ID: <CY4PR07MB275739F9422742D70D5715B9C1CF9@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499829-20059-1-git-send-email-pthombar@cadence.com>
 <1630584239.096691.685600.nullmailer@robh.at.kernel.org>
In-Reply-To: <1630584239.096691.685600.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy01YzM2M2EzNS0wYzhkLTExZWMtODYzZC0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcNWMzNjNhMzctMGM4ZC0xMWVjLTg2M2QtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSI3NTQiIHQ9IjEzMjc1MTI5NzgyODc1MjUzMiIgaD0iRmRDVEk0ZThFN2wrdzFoS3ZoWWlVZDBYOCtJPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 471ce371-9269-4bab-d67d-08d96eb143ca
x-ms-traffictypediagnostic: CY4PR07MB2967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR07MB29673BA3545696FC65E015A3C1CF9@CY4PR07MB2967.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sbUqhUNyg1pozhqW+lA89IPTtwPVw2spGlQoUhwnpx6P6usUba93Pf0I/v0gO3RnEfJPpjNkb3p6VgAWE+R98WPRcKNvgvP33ctetbM4+JTQ1ULtw4GVJaANFG21ngVhjklSDkqVBytvUSv02agIGLbYcOKoo1+ZG86VSyVXuMuYLr4UrTfhvV3BcFGBqsRuBylx3Mq0l7wP9djiBe1kx7vAwzTAi3gf+YBfiFtQbmJAy2pLFqUZ97XKX6Dc4JUACQW9gCXI7BGuyfP0zcmJznqH9/CniozGxDs1cMpGhffj8s3r6u9wQinhvdeqJsGf3mWkNAOVAiEe+X0BXivj/r59vxHwcW6MQOtih6UPqj3cTBE0qCM3ReJGoA3yCJ7jL2wa7ogRpgLt8rXD98mvU9vTQPD5ShOOfCwnqNNEX6XJ8MneZL+A3sQW2Ux9b1mZkRo9uDkLIv5MFrNzJ/FxQasq2vEap5UQjy3Sea5GaskRrtS5eBErI/UWgJxqjix3eVIrWL2+KsN91Bvru1m7cOWAZAu0I7fZTNlfX+IxDOwjCGWEpZxoA/gTn901i0YGAf19pCmaGRht30+7fbshk1rQBe7QLW89XyEaRzkY+nkAOdWB3Uw8KSSu2jxlY6N3TLy/aUwuePE4n1i53CoQD8l4XZVy4W1EvixHukTlju4vBUxp3/57yGqd0SS8PNg1D5/Ya/esNSQ5TPmZH6N+b98cMUY0uuHZfiKLFE0IhqxXk8WT6hSgywiMpVn39GUBn0GesEKU+BmHXV8TwenwzavoaAboTDtxAZCUNU9L3PT8YbWYzvm7BAMD451oqkzr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(36092001)(122000001)(9686003)(4326008)(83380400001)(8676002)(6916009)(52536014)(55016002)(186003)(4744005)(7696005)(316002)(6506007)(26005)(2906002)(8936002)(54906003)(71200400001)(5660300002)(66946007)(86362001)(64756008)(66476007)(66556008)(76116006)(478600001)(38100700002)(33656002)(38070700005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DLdZlVP3aCcWh4ZV0NaCecSW+F3bQCJUT9xqKFC2YTttSmS3qGb3v2XfkYJE?=
 =?us-ascii?Q?AV/tKhsmoVHMUJUnP4AVO2Bk+YhzB+IRIZkIAc4ZI8mI/onBs0G8Lg1Pwmgz?=
 =?us-ascii?Q?XodLm7ZrSZ+oWcPjlZS4vRUe2H6titF7+ottdDn10FScmyAk8oynSzIdHfLV?=
 =?us-ascii?Q?oJtZiAH2dj+i3evKnAqlxgLJaLovZCIiOYzKmCxhYSBXvx7AyzDDOVROShDv?=
 =?us-ascii?Q?Wf+4LQUe4I1cjskp+aN/Ibe7P0YzsBzPlfhes6m7qrJLbcjN5NdB7ZYXwQeJ?=
 =?us-ascii?Q?aPhJsNEb04yHTkpw8izll1DESEabKCNazF/uhuUIMUZHuehCfpn5uFb04OWt?=
 =?us-ascii?Q?kvdMEEvNSuZf6UZQxprL5pcHBeuFzUUjMVndng0A6TFJ1i92ommg3xhbs2YH?=
 =?us-ascii?Q?IRNIfMPikiB5iavfCZYNCYS3sWeKWpBRnhwgULp5OjqmmUjOae+Sot6uv1cF?=
 =?us-ascii?Q?8u4Q/b09vYtxZOm+axgY7aqlyxo12DIxfBpbpHScPhnBn6mB/UR0ZNdDry4R?=
 =?us-ascii?Q?LfD5Tf0W+km//gLwFUzYbvnFpgztUt1oeNEPhLOfG9pigUov8ojmB6aEzLRW?=
 =?us-ascii?Q?2ep5UmSjUPg1OV47EDr3YdfS3RUxSrKdRYQCp1fScRsoYirSDLsGu2K8vl45?=
 =?us-ascii?Q?P7LTbW98kOhgcXr2WPT05+kdcxjPFM/+Jv3iOksWas+WA+skyN1Z+CjJEZSW?=
 =?us-ascii?Q?UnPTYPS33SV2gn9I6crf48b+h0YT24/rXF/3GfRcMpP8PBHDL8z9T7wfsV6x?=
 =?us-ascii?Q?QY3PIIjPnK86+wc5bHfCBOr+fQP9JNwk6iyvT5B97zO/T+/PC1CPx/8bHGFG?=
 =?us-ascii?Q?u0NLVOEkkkzOHSCbZmCl7pberLCNDCh46v4dlUPocGgYsBxV8hVMTi1dKnNh?=
 =?us-ascii?Q?PpY7SW1SOOT1f6Nvo74u8oyxeuZPmv1hQJ1DMfKlbwQL1kzuSjdOhdZrMmwP?=
 =?us-ascii?Q?3/Rrh97WALvKBlLAVZpRIvZ80nBr20/jzzbMGdl4bGYypNNgRBf2i8qRmwLY?=
 =?us-ascii?Q?uSOlITz5EseaB3qfqy5a1Zk7+7nClDo+sdKHhl5vH7ZLpCBNZr2me+h8OCDG?=
 =?us-ascii?Q?5pnV5BfDAF4eBul3ku/9deEgK4gWhNGcCH98jDn8hzCo6G4HXFvjoycTNErA?=
 =?us-ascii?Q?yYYlJeZ8BIqL2VV0MwtaJ6vVScINNhTjaMucGMubjYQ9ugIDewpcXHlMSdWe?=
 =?us-ascii?Q?TkWsBGHN2uvTEX185WsdmJRhMNR3bx0EwcRPsKTOJR04HNB4vRs3hZpk/wVZ?=
 =?us-ascii?Q?Pd5spBcScq0EUlq0LsOfCA+xW3+1CViyNDfr5L4xLgawQJvBWkyNQbe/pyvz?=
 =?us-ascii?Q?yUfjCjPW/hA2N0pzUjxxzSDA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471ce371-9269-4bab-d67d-08d96eb143ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 08:03:07.3460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWKUGichtZsUPjjEyGF0oFMPDMZPPr54nOjbojIkBiK8L5O82/ARfNHufZNGcy3xHj3yMcFweOowa5nxRrSAqA624ykVmnAIV8Y+AmQBQ2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2967
X-Proofpoint-GUID: x6mRt_PpKHl2PSuqr3lB90Ezqtr25niR
X-Proofpoint-ORIG-GUID: x6mRt_PpKHl2PSuqr3lB90Ezqtr25niR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_02,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxlogscore=870 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030048
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

>See
>https://urldefense.com/v3/__https://patchwork.ozlabs.org/patch/1523137__;!=
!E
>HscmS1ygiU1lA!V71KMbkd1YPERLm96tbPDX_W05cj0TCcttcwVXU9H3lDADvSBnc
>5GbQunqxwGIA$
>
>This check can fail if there are any dependencies. The base for a patch
>series is generally the most recent rc1.
>
>If you already ran 'make dt_binding_check' and didn't see the above
>error(s), then make sure 'yamllint' is installed and dt-schema is up to
>date:
>
>pip3 install dtschema --upgrade
>
>Please check and re-submit.

Thanks for your reply. I will fix this issue in next version of patchset.

Regards,
Parshuram Thombare
