Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE463FFE5B
	for <lists+linux-spi@lfdr.de>; Fri,  3 Sep 2021 12:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348173AbhICKs5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Sep 2021 06:48:57 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:26962 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348180AbhICKs4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Sep 2021 06:48:56 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1836ic2t011814;
        Fri, 3 Sep 2021 03:47:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=paynf4jJo8g48cV5T21EjjfC9FC9mL7N5+VFD+XIgLA=;
 b=kQ7PGnha93Hy0fvAReZX0UwuX4XLZPQLUXS+itOMtqX9oe58tSUmjqixH1B6WR0KcvsX
 v/yu8cNaHjfOvuepCl6QH1LAle+kKgHA3r8GxucEoN6ldXNPOrf3Frt8HdmBgpFo2Ozr
 dD/vNnwYH8aHKQ5BaC3wFx0sm8EGX7q2xoYJ1uM1mk/JU4yV8PkpbTzWmLVXRa/bBXcD
 eG3u0T+86j/jxbxDsDeTmoHuXC93d0jMQS1PpjVKNJvo8SQWjvwRvi/vap/u33gL9bR4
 qzLQL4rAoZu0JpWuc/py9leXYEb5rS/UxQrtTDIBw5YS3LvLy1PGhQ2WSTZ/EiRkDsMQ FA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3au8a19vp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 03:47:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIDIYPwfpDwf62Qtrre65l9HJxDJfEcCeulH0bvo53OcS+P71uVoOzaliziWSEmSDh9c/ZvHpeDtFePe+kx0DRQfeofKezCYhUo13jCJZvNx2HOGSmqcnL6m4i2HkQtNtXjPP71Yji3YcCKBAWMteCWivQTom94TQv+QaZOI3kPpZoJtR/NZdzTS7vmI4/DojG4GnlinvCaQgjjSsjmI1f76TbClqlIPMWz02Y0Dd1leCD2jRSO6nk9a+VTJ4RiNESBE2O24hcTn61H0JHBg6LLHtbCmsRz2Ht+h1LfL/3eO982RW04ktGLX2s+FcZF0OmeJR7s1LccHnrYBltlqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=paynf4jJo8g48cV5T21EjjfC9FC9mL7N5+VFD+XIgLA=;
 b=CDbi+bRy/IYqHmWrXC3LNf6hKiU03zEa+Ce3HEErM03Swo+1rPcm399I6pZtZCQ0i08VN7LEhQDKgxe+JjJbV3wyuMmXOvB8+SVeiwSHWpWfRPdWl2fO3U24hR3tZysp7xOjZ2JS38aztr9+sR3FwWSiWocuPDsBb9nKzRTGBCVswPIBiaH4uo174fiTM8MXu5un/spnAWRTBIxlbpan23A3yF3optw1wQVc7Ckn3POwoFWk9l5U7WpfOryp/eAzEfYvSSapCef/TOVdwQRWL9Casx3XLFga4s5dLYNsl7kNhXNM/liX1lctzB/sbcFwu6CbfsvpM69kevvrsAcyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paynf4jJo8g48cV5T21EjjfC9FC9mL7N5+VFD+XIgLA=;
 b=uEmczFocJEZuz3fB8e8EiXFOiZoLa0bpDXINcvEnzaMYXmZc3Vh+1cCLrXy1tOQzEmkEc+GzDz+wPzoLVLl4S2HaXRpX3cjgtRewCaXmNAwvB0OdNQlwMoN/gzKZZYN45cp/BVB8Z14FG3pbqljsECSmub6lIF7t2/LliTi00/Q=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR07MB2872.namprd07.prod.outlook.com (2603:10b6:903:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Fri, 3 Sep
 2021 10:47:50 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87%3]) with mapi id 15.20.4478.021; Fri, 3 Sep 2021
 10:47:50 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lukas@wunner.de" <lukas@wunner.de>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: RE: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Thread-Topic: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Thread-Index: AQHXny4swnY6qQT3ME+XBZJfwQyv4auQ0mSAgAEjgeCAACXcgIAABDWQ
Date:   Fri, 3 Sep 2021 10:47:50 +0000
Message-ID: <CY4PR07MB27579742A452BC2E71D9A946C1CF9@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499858-20456-1-git-send-email-pthombar@cadence.com>
 <20210902143947.GC11164@sirena.org.uk>
 <CY4PR07MB27577F9A6DBF3F4985B014ACC1CF9@CY4PR07MB2757.namprd07.prod.outlook.com>
 <20210903101837.GA4932@sirena.org.uk>
In-Reply-To: <20210903101837.GA4932@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02MDFmYzM1Ni0wY2E0LTExZWMtODYzZC0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcNjAxZmMzNTctMGNhNC0xMWVjLTg2M2QtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSIxMTgxIiB0PSIxMzI3NTEzOTY2Nzg5NDc2NDkiIGg9InNIWHBmWFRKWm9yeUFMcjVUREV5YnQwWGlIaz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50759210-6af2-4dc8-f412-08d96ec8469c
x-ms-traffictypediagnostic: CY4PR07MB2872:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR07MB28724D6E5C252E831D0C546FC1CF9@CY4PR07MB2872.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StfyIdcDPelIkrQ/RtyT26APAUyObt6uzIH23s5aMloG/sllxZPhe9NLYfk/0OsXVkLTCc2e8NectrZqy9VoQDyoLlp2HB/pJ2tXKYdLhoLWhY4Ror7Du7OcyCgvGJa2LqVTIIMT0xe1ryA6RKDBmoOfBDuXGj/ij0Xq7jPX1l8ipNkH2wZPrrOOiYunpn6j+OPMnwMQ/J5eA4XaacTa1k/ySDAcG42SfbrU4C3E4rOASpKfhi3lqUoS63n5GfSPycMllFPN3lLics7+ewl14FvM5I9XhEIuI993BFVy74Jy+FMvRitmAc5tKpaqH3x0vTLuWvHzHfdinA2I4tQGTFs7yEdpBHGMNmpeagqQ/xotdWcvloccf+DHbStdXGh4b57/s2FwpNxAgV6vOSYlwup8za1vyIXV0EVpWfKnGiTmHeaXgt9lAP0s0GHOKq3S1TGG6eVjXsBH/SrJZSnQ9/vqUqsN75NMlTPjtTbsIrkpJxiqvaqM5tzKj4in2zdBiFv0WX9QryF0f1P74bVa+X7jC7m6k37VODONhQxOfb7ozb8z+tvAO29Ee38hCDQmwJrbLo3HtS/+sdYoINifxiJMzosxL9tCkByZrwzxhKDtNzZvh2q/EsXnPq6AIGjPUx38GOT17nlQQFU+pQMgRPfsfcXeSXpBzzpadq2Ko5XH2CRLTcoxZ8pr5KuJK2/pa+NQJHYLML2eUUYB8/ieLt05l1YPnDT1mzGRa6IRphz7lGVKveyjkdcx6Jzvfc6h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39850400004)(36092001)(9686003)(6916009)(4326008)(5660300002)(55016002)(8936002)(478600001)(33656002)(122000001)(38100700002)(186003)(76116006)(2906002)(26005)(66446008)(64756008)(83380400001)(66556008)(38070700005)(8676002)(6506007)(7696005)(107886003)(54906003)(52536014)(316002)(71200400001)(86362001)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ri9VDtlvIH0eg39JAUw3pcX4OkStGGjiPEGE2rnI0TqQczk6njXSmBbO2gXo?=
 =?us-ascii?Q?xQVkHSFJebvFdaTYtusHbvAVQhnE6z4dvfTQRmSme59I+m6INfsdQLrPE2c9?=
 =?us-ascii?Q?SIyKDi9hPOZvQAey1X+xeVDx3u0Uy/wlQ9Eb2SXOwOP6KUPkJLn+RpxpNpW9?=
 =?us-ascii?Q?ylwTdWLd3cELr9fMRxqIIiKgleNlE/D7DCKKLx9Y6tnfSrbCsB8JVMyWPmSb?=
 =?us-ascii?Q?IisoFv0C3dgC5C1N9G0lbodzUJjh4J1HboHV1ZCJ101rACFHDhacErxVHsyW?=
 =?us-ascii?Q?5hiv54pbiummdJMWVMEWQwX0ty0nrQIgnaAzPDjFc2bXPF369k983Rq/oB68?=
 =?us-ascii?Q?O2HEOUZ9wfrGGH0rCkvGaVVI5gxDMS/F9Rr+VCzqGTL7xtO4CKpfSMKsQaaR?=
 =?us-ascii?Q?cy7di3X00pmaYJpeLQE2xKF8EMon7D14GqK9itKGGFLcdNSHJmbLsUUFwBqW?=
 =?us-ascii?Q?aTn/r2YVY9lc3ahhgG7Kl/T1iwLgvrpartep96Zx6oKMArR0Q0dm21GG/grm?=
 =?us-ascii?Q?o1Z+6/ck04fI+LeolzqPTmxwjsXueX37LbKFmoY1lYX9sNeyaRLZubfdT4cS?=
 =?us-ascii?Q?tlpM+tjeLJTHMNpy8Zkn1I3mJ73gvvE5kZyUXijH3uV4C2xMH4YHTTCysta/?=
 =?us-ascii?Q?94g4ew4dpnlPjL2oB5M013N6vknReRXVEoxPiGEEeeHArVPgwDzxgKnwx1lp?=
 =?us-ascii?Q?3NtNLwIMwypxUXS2cSYuzXTlDnqLUXL3Ah9IaZw/wwrI+tnj86EvpyLvch/U?=
 =?us-ascii?Q?xxw2rtNuorQuZBA5B6YlXKSb+dvU9fP9kWs/l0ETgUhMtlbX0abPmXTZSt5w?=
 =?us-ascii?Q?HdkINT0cewKxL1G0iice9Ku8EL12WTt0B8jclSyK4evSCGamFeb0NmeS7XWl?=
 =?us-ascii?Q?NoFDmT9uXL6E1DSap3c5Ivr1L5rezd3pstJOw9ncPIwlv/DPDUyrscpynQJ7?=
 =?us-ascii?Q?eso74oBvR0s3jBzAMrukH2UJIikGhdJAJDWXXTZFyPJjMCr7pXmVln0R3v72?=
 =?us-ascii?Q?+tH0f//T9ltgXTG+WOsUEtko71PdWZzqhV44RAY0Rz027TLGRF59me5xkhS2?=
 =?us-ascii?Q?MwSWRW2PjQTuDnBhKztugr5juWHtsEl8alQgq+1f4yBCsqPx36mHkKT34vdG?=
 =?us-ascii?Q?/Bm31cGUPVBXJjwKCxIl7tr9q3/PuzzfBMTJLCb8GefdIVf86889np5UNQ52?=
 =?us-ascii?Q?ORc3di/fjZm1VCgaQt9HqhdWa/L5P/ws/HV5NJ6ZAEmPh8+Cvr9vd+hLAEPF?=
 =?us-ascii?Q?/rwTQyz9eaSg7e+ZK7LS01EmOSgHxz3u6bk1dGhpSyaTBW+VRPLEnHr4R68v?=
 =?us-ascii?Q?t0CWAkcpfcfr7knbE8mN+PJK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50759210-6af2-4dc8-f412-08d96ec8469c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 10:47:50.5422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KboFUJvnOBw3c7SQia+crIzLOr8x+Ccrtuon74syGClC8dXnpqICEQwpO7kBdz5zNUJoQxY8nMdnhEwgXQYlXAxrIx3MqChrxZa+KQ+Bvow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2872
X-Proofpoint-ORIG-GUID: ftxxG_Rk43aA8xTMw1Z5UEJPxsLwZYOD
X-Proofpoint-GUID: ftxxG_Rk43aA8xTMw1Z5UEJPxsLwZYOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_03,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=519 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030066
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

>On Fri, Sep 03, 2021 at 08:10:38AM +0000, Parshuram Raju Thombare wrote:
>
>> >> +	master->mode_bits =3D SPI_3WIRE | SPI_TX_DUAL  | SPI_TX_QUAD  |
>> >> +		SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL
>> >|
>> >> +		SPI_MODE_0  | SPI_MODE_3;
>
>> >I don't see any handling of these in the code?
>
>> This is just to declare controller's capability, so that spi_setup() can=
 modify
>> spi->mode according to the capability of attached device.
>
>In order for this to work I would expect there to be code in the driver
>which configures the controller into the specified mode.

Oh, ok.  That is done at power on reset by the controller in 2 ways.
1. Using device discovery module, controller try to auto detect the valid p=
rotocol
    mode by trying to read SFDP signature in various modes.
2. Particular protocol mode can be selected using bootstrap signals.

I think mode_bits need to include protocol mode which is auto detected or
set using bootstrap signals. I will make that change in next version.=20

Regards,
Parshuram Thombare
    =20
   =20
