Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A588632DB4F
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 21:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhCDUpM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 15:45:12 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:30284 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232165AbhCDUou (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 15:44:50 -0500
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124Kc8cd002095;
        Thu, 4 Mar 2021 20:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=cYBXn9URhSCyyzJJ+EdZ8udYFN1xL470WkDAPdfLe0U=;
 b=IeffFZis46/VdobBm5bEMTEyLcTy8h5QAebBizb6TXvsCtKl8w8U1zPgEqBnFqxP8wAY
 O86+heSxZib9YnK8gqCeYjs2FZEyQ9xsSJQd+7WZPratBgH4rBdu9UsEgcX0MYU+G2m0
 P0pH1T/d7DWn9tudBJlMBOFkrS+hrnRWBocmlhSfN4m20CnyD38RsjWGrSg4EHt8w61o
 3cJUg0/ClbFChS1X3EeZOffhjkDcRAwwYKj4MCY2AOqPge5OKK/KiRrslGljcaViZ39r
 FoQbiCZ0wsM8/5qmuMrKUczAP86fvBLdMjL+pvUsbKPLpPxwtYdw83/butnejXYKkzBs qQ== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com with ESMTP id 3720nmt2u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 20:43:53 +0000
Received: from G9W8455.americas.hpqcorp.net (g9w8455.houston.hp.com [16.216.161.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id C900562;
        Thu,  4 Mar 2021 20:43:50 +0000 (UTC)
Received: from G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) by
 G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 4 Mar 2021 20:43:50 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W8456.americas.hpqcorp.net (16.216.161.95) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 4 Mar 2021 20:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk0QXilK3WH9+W4lvCH3hcT0ylI0BbTm7amEHFqhPVPLqzCk0nV2iEFp2d7hvOQwX7F1GwJ+t9ua7UVHMTSjnWZfu4AYIklqouzlJO3OYavtxyk81e/RRE/qyMQ2VHIw2E2TbqCrlgzvj6sfvaaqTXfzyYIVIE9+dRb0Stg1sTTrHpTVh0E+jKSvDr+hevRikIk5GdoDptGujVEA/VmmpVG5tlH83j3yGYFLq2Ia0aGvqBfO5qG67YPBY0xy7SZUjhMi7Z8f91nbOeMbENc1z2HjirGD9mkYARDTGjaqFJA1zMZDrWFkpYUK7tXovaxnd6IUlI5WP9BBrdS8VeIUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYBXn9URhSCyyzJJ+EdZ8udYFN1xL470WkDAPdfLe0U=;
 b=D+VCnDexujF+z9j71s4zshgnnaby4YaBLsD27nFCT5b8cXIv7RM9+08F+7BmxkMc4cILYfONaQVa9hMhSdMIjk+pjsecGt51m4ebawqBgPPyzKAYcVeRBrHtITAUSk1r7MIAcehftG1Foyup/di2xk9HzAy9Mpr7eiG6PMeCQWM2+FwPkTg/AH31rSCbZx2hzU+IuyfF9LPeuPoVK2rvIRs+l8Zb4vQMy/eErLRr7WJwandqqa7m74UjDdgS9WG5R/7MRjfyet4hlhjEqvgZXsKPDJzL6BXFvLSwJ53d6We6xqKfOKIpduSHN+EgpUqa5xxtbLWCl64znVQRwksQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7712::15) by TU4PR8401MB1037.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:770a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Thu, 4 Mar
 2021 20:43:48 +0000
Received: from TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::641e:1e11:30c:ec1a]) by TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::641e:1e11:30c:ec1a%5]) with mapi id 15.20.3912.022; Thu, 4 Mar 2021
 20:43:48 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Brad Larson <brad@pensando.io>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
Thread-Topic: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
Thread-Index: AQHXEKjjbHsqDCsAM0uFHIpDSTWU76p0Sa8g
Date:   Thu, 4 Mar 2021 20:43:48 +0000
Message-ID: <TU4PR8401MB1055D51E8D1B48DC7D7294E3AB979@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210304034141.7062-1-brad@pensando.io>
 <20210304034141.7062-2-brad@pensando.io>
In-Reply-To: <20210304034141.7062-2-brad@pensando.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pensando.io; dkim=none (message not signed)
 header.d=none;pensando.io; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [165.225.217.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b38a2fb9-9f9b-43a5-cb13-08d8df4e3695
x-ms-traffictypediagnostic: TU4PR8401MB1037:
x-microsoft-antispam-prvs: <TU4PR8401MB1037C0F195D2841C48D37143AB979@TU4PR8401MB1037.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FZsaXyjl1Py3fHMtoU+ESp5EFs1B4iDnytUA2EenLMb+kPodPkreNR+KBc9YHhgDFtTPHUvTayDxz3DO2kbypzTtB9eup7FAdr4tcN90h3qx6NfXlXcv4nTxWVBEiT8JCG9bV1hBh/7LQkVkIXYQBfqYGqunxK9XLlObBtGRCTz1+bX9YKWXFmSzrXbTH6pyxpEInQQxsp+lHQXqOw5s41HdlzgUibFtdEAK18uffH1Xkfw0DTcDA8uG0Y2mSdMPOZfjhgqo2kZH8XWuq5DSL/bpVNBbvrnuePQbslgmg+FbSQCVt3twGe4Y7c5lhJxyRDaB2UC2oblHXzTXp5gjwoUzMu/cmKQbjL1qrs0xmJXgw61jOqF7OsB1nTxlm0Y4zFG+qU8q2ptFjfL97almhFC5NYx683OvnUXlNFY3qX4kf3prZ5z95ZvP+/f3Sx/LLskNIV9Pehy29dRT+Bvtr+uVvD2HIxavNetObUbjUUGrWpTsruV37vFUIQ76AizgNsPmX4bxjGdtlpL0MK+/9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(52536014)(9686003)(55016002)(66476007)(4326008)(66556008)(66446008)(64756008)(66946007)(86362001)(76116006)(2906002)(8936002)(186003)(8676002)(26005)(478600001)(83380400001)(55236004)(71200400001)(316002)(4744005)(110136005)(7696005)(53546011)(5660300002)(6506007)(33656002)(7416002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AwIsUqRowiW0kz0HcpeFTdhqZy3sQUQMruJNMG3g2uWI5CWO4/Snt7/9iQ6U?=
 =?us-ascii?Q?K2K2+Tx5TViZ1rUnaXNicqOhFbt18+UTNG21IqQMiJUFYyYJqg+95i50jNW2?=
 =?us-ascii?Q?5/nlUUX3F8Znmn/Sk+sajjcMreAUf/RJZuv3gZvHShNCHvQ2KyUydmTNFhbR?=
 =?us-ascii?Q?VSMwiSj4DGyK7qFN8cCuUSFhWXr6kNzl29Du8XpOldzpxswq1j31UHzITsYO?=
 =?us-ascii?Q?qtqHjHzjQotZATBG4/Qjm/4Tvdr6s/F9da3GRjBKFlLvbvmhgpP5YRpGLKtx?=
 =?us-ascii?Q?NyNc2c5nwVEpRM5fth4eXJTMXHaSfd+QI+R2T9Q1u7Y6Pm1oEkl7TOzsqg1L?=
 =?us-ascii?Q?IyI7E5zvSvwezij4qTe78jS5o4nKh2XTwEcwQZuuDl/D5qQHseDJuSBX3m8x?=
 =?us-ascii?Q?6s5By6XQ7ukgeV6nldyR3Ut0l9e5PjqNZWdt7iNDcmwAaqHFGos8iCfseU5V?=
 =?us-ascii?Q?siYqknNbBC+KeFD0VB5jebfnLOGzQnz9bZ7skOjNJyCXdwP/iwPxS1EXZJh3?=
 =?us-ascii?Q?bts5+tGBqzzwXrPbqgBNvgVqtMzhXZzUFzG82qJwJb8cU+P/TjmPtriQul0c?=
 =?us-ascii?Q?egn1GKfOgwiAJ3Yx5Q4zCDo/Wg41AcnI4gXO1tKBY4+L4BCwYpGiuDNTwGg6?=
 =?us-ascii?Q?w9PHpKM+PLbnHIg08MpbCwQbuJEPTuqyyE9j/82f7Z96XEIrzLD9/9CimjQy?=
 =?us-ascii?Q?9Wl29fOxgR07h30Z3oy9oaoWpKXIoia335/nDQbZK5viua6qiad4pPVBcds3?=
 =?us-ascii?Q?m4/t23Ms/GMzqrN+qYnEv8tZyWxWoUZRh0nZe0UQ+Dddv53YfDiMgiy0ABfv?=
 =?us-ascii?Q?zTs8IE0dyS+8TT0kwD5OqbZdb6wdnGrQuAq4M2cASmdgvOwiBV0VBIVc4hm1?=
 =?us-ascii?Q?ro4gAfw2yOjyklXAMRGmnO5OWR5+f+sqP9/XulsBK44krun46eT7hjPfsCd3?=
 =?us-ascii?Q?HQ9fMquGiYSKM8F2xNdSH17xfuIEXadZcSyghMR8aaPKvUJ63vLDMJJSuGbr?=
 =?us-ascii?Q?vgtyMvRRxZibwbxqmqXPL/2u/kIfR6eNsiXQkUKY2h801F87jsab+rF8G6UT?=
 =?us-ascii?Q?4UEPqvosdh2f95uAwJyON5X+lwZJMkheAxgOpoZMUCI/44+zcdKPIQdLzcOk?=
 =?us-ascii?Q?2W2+DvJa2Fn0MdOw8n1L6i9G4yLdN4ClcjNBRDlUyXYKjD5FjIbpNkd4dC4h?=
 =?us-ascii?Q?TLV2DgetlIRdga4ZwFuMkwp579tXX6UEp/3u2fy7zU9Y41AQznxw89Y1XXpK?=
 =?us-ascii?Q?W7UvkeR9CvCEt7kP+TsbO1FfI5ZotjN/Mbl4EfPFH1b5zqiQnwiTfx3yLhHt?=
 =?us-ascii?Q?9a/Ue/rqkiNmEj5aCbgS/Aw1?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b38a2fb9-9f9b-43a5-cb13-08d8df4e3695
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 20:43:48.7475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CvdWedLxpc1+Qy9/Z9idCHnNYwxeaUmD2Z6vQl/Q0LFR2kj8qyG8c1yaahy2p5ll
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB1037
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_08:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040101
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Brad Larson <brad@pensando.io>
> Sent: Wednesday, March 3, 2021 9:42 PM
> Subject: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
.
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
...
> +config GPIO_ELBA_SPICS
> +	bool "Pensando Elba SPI chip-select"
> +	depends on ARCH_PENSANDO_ELBA_SOC
> +	help
> +	  Say yes here to support the Pensndo Elba SoC SPI chip-select
> driver

Pensndo should be Pensando

> diff --git a/drivers/gpio/gpio-elba-spics.c b/drivers/gpio/gpio-elba-spic=
s.c
> + * Pensando Elba ASIC SPI chip select driver
...
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Elba SPI chip-select driver");

I think it's conventional to include the company name there, so
start that with "Pensando Elba"

Also, "SoC" and "ASIC" are sometimes included after Elba, but sometimes
are not. Consistency might be helpful.

> +static const struct of_device_id ebla_spics_of_match[] =3D {
...
> +		.of_match_table =3D ebla_spics_of_match,

ebla should be elba


