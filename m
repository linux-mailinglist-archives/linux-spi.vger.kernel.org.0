Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287FC403901
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351517AbhIHLl4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:41:56 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:14034 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235453AbhIHLlz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:41:55 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886dfkr030286;
        Wed, 8 Sep 2021 04:40:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=FfxG+PuhEao9aT2spiLh/Tmmtcr3i+C0ZqD6Quw5dj8=;
 b=q3jpbUSnAkGIOGI79tv3+AXE0S+POiqjxIJBpYNRR5lmI8vL1u1TkUKbhQg9FkdZJP/9
 iI5OKG0f1FhKgjKuKBRm7haQ4GaTPp5iAAuVaBg2ill7Oo9kxESpZyRcySz1Em8NRyLB
 n18MUbGoNQz2QKx1LNnAf9+C9uciwJQAl1T7f3Nyjuik+A8TmCGYwrMtQ2WCZtL57SEH
 Nmcahny6GInDye95QDzXsMcD2szpIyln3FyNOTcLCOHwQ0CxIwq46dEdm+tID/iijAh4
 WkSIyhNstVehfm/6ZDhPiazUCrXHe32Flm9RFbMlDUENzNX8VizvoxcTjmqgTxFzTEdw Ow== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5aw42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 04:40:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvof/0b+Za2ACjtjriRMHkO4Sru4+yF90jSWO9bwLkMFAMVj0+CAOH+JArb4KOapvaw9FFlzOebyFWHgzt2mUvyThuvMC4MLOypWXPtUjgBO6CVLnbDbYfIQWUIqYZEJtpJBajkaXgAOooMZbIfSkNwJ+wkzO1GFfMTji+LmGt/v0JbSfs5BRpT82+YP0jt41003N7LAP1kESPh+6oAwZoUaxKun8CnHyKlQDYiJ1F4o3bHP9wMU/LlKQ1Qy+nTX028ZJiMwibFjEhy0XPn/7pKg4SqH1OkldaIBoRA8Rr3cLMoUuPC32B/rRJzXQIF8N6UaJUwjiUB2KKDxrJjhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FfxG+PuhEao9aT2spiLh/Tmmtcr3i+C0ZqD6Quw5dj8=;
 b=AAVkcAHy8a1l8Zt6iT0GtG4crTq+Dg3Mk32/E6U36d8DRAO4MUlaeafVR269ONeSYq68NDhMTwTqexk8ysKePdnTiDwJjavvcJo5+MRZUFF2Cf+Brv5S5jNQzG77pnc4nO2tdaXSQjJq4HdzstkcjNa/yP0UwDwbB+cWcdKLoahFE5IIIFlvPVBL65IDaMuDBmm98YqaktXQNZe8v0tcG+mrhQVEcAQMHJbq0m4M9s+pWY362rQsb9OkA+kOsGk1DFyiCH+WODadCxCLCp2XXcRfwqFtHMOqDSfmAx7BN006E3G3jKpKdck9O6GaBVNx/o9ko8aqU4+JBolkeKqVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfxG+PuhEao9aT2spiLh/Tmmtcr3i+C0ZqD6Quw5dj8=;
 b=a+fBIoNH09oRQroLh24lh+y6ncA8iPsXt/l0PjC8ixoDk6nWn64LpEru6/weBkn2HxK0dlLnxMGgWCRsLDXHs9zV7L5no5y5zGo0E8QW1lSEjFQSsJReNdqY9vLnt/9mkODI2hoxNdKuQ/Xk79zGn2v5u7qh9iYF6StLiESROjE=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY1PR07MB2650.namprd07.prod.outlook.com (2a01:111:e400:c61c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Wed, 8 Sep
 2021 11:40:37 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87%3]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 11:40:37 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: RE: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Thread-Topic: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Thread-Index: AQHXny4swnY6qQT3ME+XBZJfwQyv4auSrJGAgAcSyHCAAEmQgIAAAVsw
Date:   Wed, 8 Sep 2021 11:40:36 +0000
Message-ID: <CY4PR07MB27579FBD95645298B143B517C1D49@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499858-20456-1-git-send-email-pthombar@cadence.com>
 <20210903185653.7vrfn4qfzvuiaiq2@ti.com>
 <CY4PR07MB275737A008CBB58C4B108D2FC1D49@CY4PR07MB2757.namprd07.prod.outlook.com>
 <20210908112113.smnwmayjb3jit3eg@ti.com>
In-Reply-To: <20210908112113.smnwmayjb3jit3eg@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05M2Y5YjIzYS0xMDk5LTExZWMtODYzZS0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcOTNmOWIyM2ItMTA5OS0xMWVjLTg2M2UtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSI0OTEiIHQ9IjEzMjc1NTc0ODM1MDcwMDcxMiIgaD0icVJSazhzWkZvRGNQK2FJZ2xkUEEyN1pUeWtnPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d41d3e5a-2019-4cba-65af-08d972bd79fe
x-ms-traffictypediagnostic: CY1PR07MB2650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR07MB265061B6A0CF3109F13A486DC1D49@CY1PR07MB2650.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: quqfUWn9ht2gx57IvlEEZZzpnosqR6Ujugg+qaFOnL5AElg2JPjMy+e1wr/Nb3+5hQApv6UV+t9HB9EsBA4cMt8A7TP8YP1vZ0b/6NlGx4eZkhNYmGg+kUm2qAuSW/jt33lRmy4dUs5YE2kjGYiLN7HVIDSFn0vg4yAnyQjW3kmy2CYLBcFf0K7beACXCB0PD0u0h3qquxVX/PUkpzhoxC7G4+n8/PiOVkabyLhtlev9Mz98mOFypztuhOc+11ahpj6cbbwNIuaWfgpsNCMdNI+M2NES0lJ/eqXBMEhEXHY/Cqb9iEKp+bSvFWDWHJouM6WiARERYxvU2DNKU3HlYD5v6F13aEC/5/R1/tCaIuSv1FJWkSzrq2VBHFuGp8+ToJEspdoUIsvMY7W1fBLV6/sR/yEUERKrbjO3rX0tk+HHJN4fGoobOOfTyEcdNGnb+jLCVLEFo2rvRbnf/dYPR8C5tnJwnlh0devvwjjXX8z0zfll0OAfJWefhI4ENSyUhQbtf69G6fuqr4n4SGnA1M/BK+JryNBhPRy90ZxJIZt8muUFZOYyhz3dYD+DPYCRHSFyevRfdQCaJlTYWp8KQuoVmPK8Z/MCtwIjpyrHmt2u0u26oiSR8uUAoPP+uq3SL+tY5/BKY+4gLXbD+X2D+jwDn5TuY8ePmOEBLGpZJlACzMNyL3ABOk8yzjbQlbkoJs4vRfscMxpToNE2tzSyV9RmuR7X+TrPjW/p52qiLOIGdEI+mABXneY4JmcjEILA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(36092001)(66476007)(66946007)(66556008)(66446008)(76116006)(122000001)(64756008)(38100700002)(5660300002)(38070700005)(4744005)(186003)(478600001)(26005)(8676002)(4326008)(52536014)(86362001)(6506007)(33656002)(7696005)(8936002)(71200400001)(9686003)(54906003)(55016002)(316002)(2906002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fyKZzqm3ZRqwVtxip2VpIBAXUFb19ECsHQ6bqWhwLp+d07sjFO/DEWnLdb3o?=
 =?us-ascii?Q?67bZb6Qtqq8pI7rO3lQCp+QOgvCKQh3Bz5DeZ0bNBtP8vURGzugxXZFvgF8p?=
 =?us-ascii?Q?d3r9cMBn3CINdzj5boUZSQuTDQ6hUDMKef+IVFJNYPZ3ieqgRpK/xVlqp3b2?=
 =?us-ascii?Q?g838pEIWZbYIAs1rCHG+oPHZihkkSVPu1NsCnpMgyoU19OCDeSPXBjnXVNLY?=
 =?us-ascii?Q?49MaTO7ii6oBvvsx+uSR+nYlOXRsS92Q+3mnoC3r7ekpEmP838AHylVveb0+?=
 =?us-ascii?Q?gtkk612yhGmPZd5I0qpWyjVh8ri3mBwmrTxuHE7hU33kILNt7gM3lyCKIomu?=
 =?us-ascii?Q?Kgr2MZtFwWGqieyCcztFONHBvWs4KRQ2glwqDI74kKqQbHYsr1luNrfBC85O?=
 =?us-ascii?Q?lotPGQZWdtfCMvs0etY20FX3M6Cs8GXtDYdwZV62MorItiGX+Em8jhMxwEDO?=
 =?us-ascii?Q?e6CoYhmwVpsUfnweg8KYRR/ih2pJofgttuE8rhkghu+QpbkOh7RiJKxlrGJJ?=
 =?us-ascii?Q?GTuwXt/iPwD9a23DYv0xVSmYUY/fnBQjOFWz0AYXS8age+SsYpmj0x9Ksg+j?=
 =?us-ascii?Q?eyMBGcT8FLTiMOTS/Nh4HFGnesHPLPaD/EOQnW7YLzFaT09DGuACJrILzUUG?=
 =?us-ascii?Q?by+7N6JhTCuKu/Ol/JZXy9dwdjQZBB/TOmC5c6yo2pcPKPXb8WNyE21EQnto?=
 =?us-ascii?Q?K+6W0TEQK28LGK759pzeEcQeFrs71cM8isdXgfOkJO1fl7mCyANesF1D9jAW?=
 =?us-ascii?Q?QLLWBu8a7z9wytNzU2bBHTdgqQhjn5rqinYTgsHkaeJ5nCBOyxoBF2AIlqhR?=
 =?us-ascii?Q?VU94cOL8TtGNL8UmahCyqOsnR5bMcX/pSf08e1dkZyLj313W+X+WIGK5nRQC?=
 =?us-ascii?Q?JiUEcDKIl2ZBlmfCPh58jwDxe+9OKMXGGSL8uvkGmFs1BX7WbX28EBpMKH9Y?=
 =?us-ascii?Q?zuROIfuVzJ92ZC3+Q66J0xrPfa8zTKGHZc4SHga7lxOf6p99WiRtqu9Jcc0s?=
 =?us-ascii?Q?FXUYijB8rC/lxeJzn+poC7IG1H3VPBLr5n1XymU/0Kw5ytHa5xsYh6cTYxS7?=
 =?us-ascii?Q?jTckWiPICnl49FmKNkVWVrXBWtLl7GbM9Dk3I9zhniERNlgcdPEtSe+I+v0Z?=
 =?us-ascii?Q?S1OtxY9v+qnRKQFFathPfrpyuvr/5KbKra+dWaVVCTpIoBDbcmRaEiItHkFT?=
 =?us-ascii?Q?V37F24fdgdEtII3C+nj8UdyRdDTo0G7fQN/OQr1u2Cdvkmf9xoEvefJaro2T?=
 =?us-ascii?Q?rFEsceRJAveQmMAISNFAcdS2ibZ+bUKVxXndylpPyfyL0X9hRCHTigjARu1W?=
 =?us-ascii?Q?pQOyhY2OMHCcig82jgvrsTRH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41d3e5a-2019-4cba-65af-08d972bd79fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 11:40:36.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fadsWht5XlqpcLlwnj6SXmIdkfAEUruSlt8qiIv7UhiEct+Qz6KcgT0InEExzR9m0MShVIRs3FpTRgv9PqjyIuYb88sTP271FDFhV+KlDtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2650
X-Proofpoint-ORIG-GUID: uMEv3fUvwFmPAQu2WZoW0mOjtyxQGf_R
X-Proofpoint-GUID: uMEv3fUvwFmPAQu2WZoW0mOjtyxQGf_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_05,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=521 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080074
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

>But it would reduce performance by a lot, no? I think we should try to
>figure out how we can accomodate controllers like this before resorting
>to using the slower modes.[>]=20

I am not saying that functionality will be restricted to STIG mode.
But we can merge base driver with STIG mode for now and add other
functionalities/modes incrementally.
=20
Regards,
Parshuram Thombare
