Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97AB338B6C
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 12:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhCLLYY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 06:24:24 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:22791 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhCLLXx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Mar 2021 06:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615548234; x=1647084234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xCf6jAM0/8fNBQEybe1HPVg0B1BmtiMucJMgIUR8TfI=;
  b=f/U5tjThI0nKPTW8oqDvotR0kch04uF9IMAslGPDU6peq29TLoiCaR31
   tTXnPa6YTl8KoIzDi6akfd3n4DrzYbssPz9+5sudv8BDBC0VrhAAmjsxh
   lT69Qqbf15cI2fqt1JEyljdDsBBkQGP0CDR5OR6CTzqQboGeMT3+dvsWM
   N//JxtCJtQy4tJRIaVlvhxoDqYgiM8BpPil9x4JZbaUXahbskcuXZuN73
   cU5MTOYle3PtcC0zk2hZhB8RB1QkFJhvQ6RMcskNydkNX4NO5WJODb/dg
   P7gwZ4QAU654JCb29UGrpvr62TWfoO9UL2eYQmvLRdgsUGALh4Alcogvf
   Q==;
IronPort-SDR: f39UmCMJ8KNR9KhpGf6zhE+MbzEFZI0xFo7PUutazt36l5gW6shqc5m00bmdPnE9KNi/aWOhuR
 wDasVS/o8/fYn+0lR/o/008jWPJKWGfT7UqUr+GRhorcl1NUgTdyIHZlovjRpvhUTZVKiVAmol
 I0mdtPIbKF9axM1DXTTf1c9SeSDLxP18gb+9GAYmnGrBmwupBxQWN5IESZpmGwIOeJSqeWt995
 2rjbxgQDA6n0h9R+TUxJ0D3g5NRahvdsIkKjQwIYQwZiJBJsfYsCTk8DnSg7q31Fs0t/GPz4g7
 /k4=
X-IronPort-AV: E=Sophos;i="5.81,243,1610434800"; 
   d="scan'208";a="109745296"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Mar 2021 04:23:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 12 Mar 2021 04:23:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 12 Mar 2021 04:23:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klcxhTYpa+WODg5Xuu8EKI6f35SrH1kNRdYxdmG1ah5C+dFq+b2x9b0m+Joap9DaxL+2QNKWPxKXtUwpefHedHVbvKCaNCHVfFa0lQz3TzcA3NncXXfRijvXbf3+lY0Ob+ZbY0DXVXpsjOCR0LSgAD2HNbA2DMICzFvCbwLe3OXJTTlERmnJIbasRCEF3SuLbK9CgHWr5jnA9zjLP/wWNrOVSpS1lkgaDlasAGlXTRf1ycan7qACPQ3lrfixgimoo3VE06LJNjjCRbbhW7BG5RYQUYY8mK3Fj8w29r/MNPyVICEUHhEMRBCilWOf4OD1LP1fDkCo8w6pzz2YRtresA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCf6jAM0/8fNBQEybe1HPVg0B1BmtiMucJMgIUR8TfI=;
 b=GWYmTDTz9MeUrnwJwI6QC2WA6KzF6E18gJc6hCEcgZFiIBmTQ2SYr9lXH5Uqb+cEkHym2oc7d5Tu2Yg3zr86M2Is8EV58oDOtN+Bvk4LPYqIKi+M+4vfM9Uw0w4Mm67o3atItcfIY4/Ac/yuaWHOKCnIALLB1n1F7SFM260R2hlB1yVW8m0m0COoDthSOZqscU6uw2Cqgup/Qa4w67DTrW8dCerTUYRt+5ftAX7s6c2vczkd104Kf8yLjBXILbDlxuV0tfld3ND6e5THCniGiRM2y4Fp9iXFQ0/oAS3oYeAxcb4lwriQOTLRH6fdHCFrYSWlqx3dU34G2fjfrRUpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCf6jAM0/8fNBQEybe1HPVg0B1BmtiMucJMgIUR8TfI=;
 b=mJ33kwCn0SOxKxX543zqBK8v2oXWtGWVYFwl7RZQIkb0/epaQnTri94f4N9vZJ5mSkjT3hNv0MkfSVos1BojQSunw0H4nJFQObKoMEWUkyGl7USM8IZe8/De8wz/+C/YLK6ab1K9aBGSzcpXAMymOK2+6s3f+ctaaC9z4Oo3ZqY=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 11:23:48 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f%7]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 11:23:48 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 0/6] spi: Add OSPI PHY calibration support for
 spi-cadence-quadspi
Thread-Topic: [RFC PATCH 0/6] spi: Add OSPI PHY calibration support for
 spi-cadence-quadspi
Thread-Index: AQHXFx9voVlY5U/87kSEhShnaEXyTw==
Date:   Fri, 12 Mar 2021 11:23:48 +0000
Message-ID: <25a72752-097e-5669-7087-1cf6da38b3ba@microchip.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <9c551f56-4c00-b41a-f051-8b7e197fbcdc@microchip.com>
 <20210312101036.jfz2733ssv4nhfey@ti.com>
In-Reply-To: <20210312101036.jfz2733ssv4nhfey@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d53c1e2d-cb34-4184-ba1e-08d8e5494e53
x-ms-traffictypediagnostic: SA2PR11MB4891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB4891E472960EA53C239A2398F06F9@SA2PR11MB4891.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gwjs1z3tkVP7hB2r0XFYytTIo4dIAwU9XTgeFTXmizSCNHB6LdsXVMZoYJt0KpXXAyDyHxdDZ1lV9wFJe22I0sUZ9LImh0lpYNZ0csxwJLRqeOKwt4chXZr/LpuPNja+pYloj+DCf/sD0boSkPXPZHwyXXqI0tFsSELrHft3fY8pzAWvsV+y49H4zMIZWoy84/6v8KcbUWOiRnlBXXWtU9xdOkj9LkhJGvWnRkve3Klp+2EKkt6ys6t8YG+klmJBhquNHZs0GyFg72b33uZXaHfX+2M3tNxD9UEedV/Ox4KADROP5T8USvPwCFCGtIjbb2VCiROMN0b4xrxbvlT8q+snE/cRLC56R3HkO6P8xqEW2KlxhXt2eWBGp2f8l8sAsCe59RvmOYBvnjgciVKmY68zzqIzyHjASnSIdANZoLO4uodxRdClmAcDY/dUHEw+Hr/WL/6R5IxgjSvZzcgb5SbiVSw3k5QJnZAN+hgeYZa8xcp0dN6xrpN64akmz7hqRy0mK6c59ZKC3pVzCeGGc/eMt5z9eXpGChhgF3KkQhkKkwnWKsvf/wps5C6s1aeirrd9GvQO6LqBZHa1aHpOPI75BVSKM2LnsYp44ohVhjtjblZIP+hBbAspsT3B/kQOLOrUpRIICB98EWB2q77/dgdWsgcK1vCZlWl4dS55OsBWTESioepaA8tOsQbWRDJ7htpfRuJmV6ZCCwKLbwDTppy/YdLWNBMO6dkdfIXTTkA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(396003)(346002)(366004)(376002)(5660300002)(66476007)(66556008)(66446008)(66946007)(6486002)(4326008)(83380400001)(53546011)(6506007)(64756008)(8936002)(76116006)(91956017)(7416002)(71200400001)(8676002)(26005)(966005)(86362001)(6916009)(186003)(36756003)(54906003)(478600001)(31696002)(6512007)(2616005)(316002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cURrT1dRRWIwbGpUZGRqWjlqYWhSdldNSHZBeWJlZGMvZVBjdmlvTkxBdHUx?=
 =?utf-8?B?NGpwbXpHUGFzM1JYT1FLVEFHdFhTbGhsT0hsMmEzdkErQjhXOVBHSVNxZTFq?=
 =?utf-8?B?Z2lLY2ltNktOSXh3dG5sQm83TWdVQzhQR0lYcUdETC9rOTdDOFBXdC9NcVZQ?=
 =?utf-8?B?SE82Zkk2Mm45VnRDWXFYVkpndEFiTjRJaUpuK0YybkVvejdyc2loYjRrWlls?=
 =?utf-8?B?WlMxZGRvZVBrMmhtWERUcFZpbXRaSG12N1FNWWtPckdybG9vWkQ2UlVLQ0RV?=
 =?utf-8?B?cGZ0YS9lRklZZHJqeFVtbFkyaktJaUx4Tm9yRGpjVTFFWUN1WllyR25BS3gz?=
 =?utf-8?B?QmttMkdmanFIUHByYlBuOXhxcGpzODBHUjNYTFNFQVdaaXlMenI5YzlCSjY3?=
 =?utf-8?B?ckZuNytqaUpDUExVSU5hQXhTWG41WmVySjM2aVpHWmVOMlNxNUl5R1RzZ0cr?=
 =?utf-8?B?T3RGRTdNS1BmSXFLRXFXMTdzZHBUS0hSQXhHWC85TDkxQ3lIRjFrNTROQi80?=
 =?utf-8?B?QWg5SXBiRTNtMS9rdFpyeDVGREZZOSsraE9tRStxT0ltUkF3S1RFc29WbHZu?=
 =?utf-8?B?Sk9zV013VDZ4MXd5TzRmcVJNOCs0TnljaUdVZDVMbkRtV3hJNUo1K0lVT2k0?=
 =?utf-8?B?TVpNOW5zNTBUbW80M3NCMDZFR1hGZEdaVmxFY1Z6SDAySkNSQU14SnU2cDR0?=
 =?utf-8?B?NCtsOUtscWFFenBaL1VMb2NvYWh5K2FIaU1JUE1ZQnY3NmY5cENOM1ZXSWdt?=
 =?utf-8?B?RGwxNVNqNUxFcTF6WXRDNEFhTmt0V2JGNHczZDlra1FYcEJ1VnlubENmSUlo?=
 =?utf-8?B?ZStvejN4Q2ZEVks0aEdBQzA5QWxxQjhUbURaemFicVZpMGZWdGhyUFc2MUN3?=
 =?utf-8?B?U1doT1BodW03clhoQVJWSHhDckc3UW1DdEwxbmFhVFJUTk5JMUYwRWdSN0V0?=
 =?utf-8?B?TkxjQU9YS0ZyUEpxZUpEbWNtTEVXemk5dHV3c2VocmcxOVpGcTEwWnRab296?=
 =?utf-8?B?bzNENWIxbHhKNGM2dndSK0lpSE1pK1BBRU90ZXVaMEEwVHpJY1IxMFk2ekRp?=
 =?utf-8?B?eVI5RjBRVVF4UDYwZnJ6b2tmK0dzcnp3ZnBRVFVjcDZueXpudVZ3YmVHVXVn?=
 =?utf-8?B?UXEybEtGUzFyY08vYXlmU2JKRW5GeE0yejNLTmQ5cDd0SkVmMXZyR28xaG9X?=
 =?utf-8?B?OGlraURmdUdjdU1pSlIzL2FQVnlyY0ZIU0Rqdk5CY254WURoZlVwcUtJRHgz?=
 =?utf-8?B?TlVKYll6M0NRQ0NONFNwSHAyQTRma2dDSXJUMG1acjNGeHlRdFlSaHlGQVZt?=
 =?utf-8?B?VG9YNUEvY3pTZkxKZ0lLa2twNm9kYWU1ZFdReUxtYzE1YitRMVhidHI3U29R?=
 =?utf-8?B?Z3daQXNpbDNrOHlQa1U5cCszQW1OTStMSjE0Z3U4SUpnNWwzRExWS1UycGNJ?=
 =?utf-8?B?dWNlM28xTmVDM1NYN0xaZnFOSThXc2NSQ0VSZFRZTU1nR24vdnFsQ0RRbXJp?=
 =?utf-8?B?MnJOcmJSN2dLZmFkV1llQVNPcExwQ1RXOEhQRmZFZVBnWktpUDkzTENNR21j?=
 =?utf-8?B?MDR5Mk42dGcwdWMzaTlBMmhvZXlXRGtsdjhMRWlZaGxPbm15cU9ERlpQTWNP?=
 =?utf-8?B?RkFYNlJYOXByK2o2TTRaWVF6NnhOWGlnVzR2ZWFNNy84eW85blMwZWxya2pa?=
 =?utf-8?B?TWIvNTBRcTY3djVFbFBTSTgvQ2ZhcG8rU2N2SDVYVUVJbVJ1TmJ1SlZuNnFU?=
 =?utf-8?Q?zUyrqai7QJjtfJrLgE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A96FC37D69134A4FB4EF6608255BD87C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53c1e2d-cb34-4184-ba1e-08d8e5494e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 11:23:48.1751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rtn6gGsupmn4pRzVmvOX8Ih15oGibCaRAUtTqNXjqLcAF5Pf/PmEVnNWf8LPNfZ4LGgyYNrRxU3dhZsKfR+K5SgG19h6hDO8SJ9UU+yYBTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4891
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMy8xMi8yMSAxMjoxMCBQTSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMTIvMDMvMjEgMDk6MDlBTSwgVHVkb3Iu
QW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMy8xMS8yMSA5OjEyIFBNLCBQcmF0
eXVzaCBZYWRhdiB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+IEhpLA0KPj4+DQo+Pj4gVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBPU1BJ
IFBIWSBjYWxpYnJhdGlvbiBvbiB0aGUgQ2FkZW5jZSBPU1BJDQo+Pj4gY29udHJvbGxlci4gVGhp
cyBjYWxpYnJhdGlvbiBwcm9jZWR1cmUgaXMgbmVlZGVkIHRvIGFsbG93IGhpZ2ggY2xvY2sNCj4+
PiBzcGVlZHMgaW4gOEQtOEQtOEQgbW9kZS4gVGhlIHByb2NlZHVyZSByZWFkcyBzb21lIHByZS1k
ZXRlcm1pbmVkIHBhdHRlcm4NCj4+PiBkYXRhIGZyb20gdGhlIGZsYXNoIGFuZCBydW5zIGEgc2Vx
dWVuY2Ugb2YgdGVzdCByZWFkcyB0byBmaW5kIG91dCB0aGUNCj4+PiBvcHRpbWFsIGRlbGF5cyBm
b3IgaGlnaCBzcGVlZCB0cmFuc2Zlci4gTW9yZSBkZXRhaWxzIG9uIHRoZSBjYWxpYnJhdGlvbg0K
Pj4+IHByb2NlZHVyZSBpbiBwYXRjaCA1LzYuDQo+Pg0KPj4gQ2FuIHRoZSBjYWxpYnJhdGlvbiBz
ZXF1ZW5jZSBiZSBhdm9pZGVkIGlmIHRoZSBjb250cm9sbGVyIGlzIGluZm9ybWVkDQo+PiBhYm91
dCB0aGUgZnJlcXVlbmN5IG9uIHdoaWNoIHRoZSBmbGFzaCBvcGVyYXRlcz8NCg0Kcy9mcmVxdWVu
Y3kvbWF4aW11bSBzdXBwb3J0ZWQgZnJlcXVlbmN5IGJ5IHRoZSBmbGFzaA0KDQo+IA0KPiBNYXli
ZSBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBjb3JyZWN0bHksIGJ1dCB0aGVyZSBzaG91bGQgbm90
IGJlIGFueQ0KPiBmcmVxdWVuY3kgb24gd2hpY2ggdGhlIGZsYXNoIG9wZXJhdGVzLiBUaGUgY29u
dHJvbGxlciBkcml2ZXMgdGhlIFNQSQ0KPiBjbG9jayBzbyB0aGUgZnJlcXVlbmN5IGlzIGRlY2lk
ZWQgYnkgdGhlIGNvbnRyb2xsZXIuIFN1cmUsIHRoZXJlIGlzIGENCj4gbWF4IHN1cHBvcnRlZCBm
cmVxdWVuY3kgZm9yIHRoZSBmbGFzaCBidXQgdGhlIGNvbnRyb2xsZXIgY2FuIHJ1biBpdA0KPiBz
bG93ZXIgdGhhbiB0aGF0IGlmIGl0IHdpc2hlcy4gVGhlIGZsYXNoIGhhcyBubyBzYXkgaW4gdGhh
dC4NCj4gDQo+IEFueXdheSwgdGhlIGV4YWN0IGZyZXF1ZW5jeSBhdCB3aGljaCB0aGUgZmxhc2gg
aXMgcnVubmluZyBpcyBub3QgaXQgaXMNCj4gbG9va2luZyBmb3IuIE1vcmUgZGV0YWlscyBiZWxv
dy4NCg0KSSB0aG91Z2h0IGFib3V0IGNob29zaW5nIGF0IHRoZSBjb250cm9sbGVyIHNpZGU6DQpt
aW4obWF4X2ZyZXF1ZW5jeV9jb250cm9sbGVyLCBtYXhfZnJlcXVlbmN5X2ZsYXNoKQ0KDQpBbmQg
dGhlcmUgaXMgYWxzbyB0aGUgbmVlZCBvZiBjaGFuZ2luZyB0aGUgZnJlcXVlbmN5IG9uIHdoaWNo
IGFuIG9wDQpydW5zLCBsaWtlIHRoZSBSRUFEIFNGRFAgY21kLCBmb3Igd2hpY2ggaXQgaXMgcmVj
b21tZW5kZWQgdG8gYmUgcnVuIGF0DQo1MCBNSHosIGJ1dCBtYXliZSB0aGlzIGlzIGFub3RoZXIg
dG9waWMsIGxldCdzIHNlZS4NCg0KPiANCj4+DQo+PiBDYW4geW91IGFkZCBtb3JlIGRldGFpbHMg
YWJvdXQgdGhlIG9wdGltYWwgZGVsYXlzPyBBcmUgd2UgdGFsa2luZyBhYm91dA0KPj4gZmxhc2gn
cyBBQyBjaGFyYWN0ZXJpc3RpY3M/IElzIHRoZSBjYWxpYnJhdGlvbiBzdGlsbCBuZWVkZWQgaWYg
dGhlIHVwcGVyDQo+PiBsYXllciBpbmZvcm1zIHRoZSBRU1BJIGNvbnRyb2xsZXIgYWJvdXQgdGhl
IG5lZWRlZCBkZWxheXM/DQo+IA0KPiBUaGVyZSBpcyB1c3VhbGx5IGEgZGVsYXkgZnJvbSB3aGVu
IHRoZSBmbGFzaCBkcml2ZXMgdGhlIGRhdGEgbGluZSAoSU9XLA0KPiBwdXRzIGEgZGF0YSBiaXQg
b24gaXQpIGFuZCB3aGVuIHRoZSBzaWduYWwgcmVhY2hlcyB0aGUgY29udHJvbGxlci4gVGhpcw0K
PiBkZWxheSBjYW4gdmFyeSBieSB0aGUgZmxhc2gsIGJvYXJkLCBzaWxpY29uIGNoYXJhY3Rlcmlz
dGljcywNCj4gdGVtcGVyYXR1cmUsIGV0Yy4NCg0KSSB3b25kZXIgd2hldGhlciB0aGUgZGVsYXkg
YWR2ZXJ0aXNlZCBieSB0aGUgZmxhc2ggbWF0dGVycyB0aGUgbW9zdCwgd2hpbGUNCmFsbCB0aGUg
b3RoZXIgYXJlIG5lZ2xpZ2libGUuDQpXaGVuIEkgdGFsayBhYm91dCBkZWxheSwgSSdtIHRoaW5r
aW5nIGZvciBleGFtcGxlIGF0IHRoZSBkZWxheSByZXF1aXJlZA0KYmV0d2VlbiB0d28gY29uc2Vj
dXRpdmUgdHJhbnNmZXJzIHdpdGhvdXQgcmVtb3ZpbmcgdGhlIGNoaXAgc2VsZWN0LCBvciBhYm91
dA0KdGhlIG1pbmltdW0gZGVsYXkgbmVlZGVkIGJldHdlZW4gdGhlIGFjdGl2YXRpb24gb3IgdGhl
IGRlYWN0aXZhdGlvbiBvZiB0aGUNCmNoaXAgc2VsZWN0LiBUaGVzZSBhcmUgYWxsIGRlc2NyaWJl
ZCBieSB0aGUgZmxhc2guIERvZXMgeW91ciBjb250cm9sbGVyIGhhdmUNCnN1Y2ggZmllbGRzIGlu
IGl0cyByZWdpc3RlcnMsIHRvIHNldCBzdWNoIGRlbGF5cz8gSWYgeWVzLCBpcyB0aGUgY2FsaWJy
YXRpb24gDQpzZXF1ZW5jZSBzdGlsbCBuZWVkZWQgaWYgYWxsIHRoZSBkZWxheXMgYXJlIHNldCBj
b3JyZWN0bHk/DQoNCldoZW4gSSBoZWFyIGFib3V0ICJib2FyZCBkZWxheXMiLCBJIHRoaW5rIGFi
b3V0IHRoZSBpbXBlZGFuY2Ugb2YgdGhlIGxpbmVzLA0Kd2hpY2ggc2hvdWxkIGNvcnJlc3BvbmQg
dG8gdGhlIGltcGVkYW5jZSBvZiB0aGUgRmxhc2gncyBJT3MgKHdoaWNoIGRlcGVuZHMgb24NCnRo
ZSBmcmVxdWVuY3kgb24gd2hpY2ggdGhlIGZsYXNoIHJ1bnMpLiBBIG1lY2hhbmlzbSB0byBjaG9v
c2UgdGhlIGJlc3QNCmZyZXF1ZW5jeSBhbmQgaW1wZWRhbmNlIGxldmVsIGNhbiBiZSBhZGRlZC4N
Cg0KRmxhc2hlcyBoYXZlIGFuIGludGVydmFsIG9mIHRlbXBlcmF0dXJlIG9uIHdoaWNoIHRoZXkg
YXJlIGd1YXJhbnRlZWQgdG8NCndvcmsgKEkgd291bGQgZXhwZWN0IGluIHRoZSBzYW1lIGNvbmRp
dGlvbnMpLiBJbmZvcm1hdGlvbiBhYm91dCB0ZW1wZXJhdHVyZQ0KcmFuZ2VzIGFuZCBhc3NvY2lh
dGVkIGRlbGF5cyAoaWYgbWVhc3VyZWQ/KSBjYW4gYmUgcGFzc2VkIHRvby4NCg0KQ2hlZXJzLA0K
dGENCj4gDQo+IEF0IGxvd2VyIHNwZWVkcyAoMjUgTUh6IGZvciBleGFtcGxlKSB0aGlzIGRlbGF5
IGlzIG5vdCBhIHByb2JsZW0gYmVjYXVzZQ0KPiB0aGUgY2xvY2sgcGVyaW9kIGlzIGxvbmdlciBz
byB0aGVyZSBpcyBtdWNoIG1vcmUgdGltZSB0byBzYW1wbGUgdGhlIGRhdGENCj4gbGluZS4gSXQg
aXMgdmVyeSBsaWtlbHkgdGhlIGNvbnRyb2xsZXIgd2lsbCBzYW1wbGUgYXQgYSB0aW1lIHdoZW4g
dGhlDQo+IGRhdGEgbGluZSBpcyB2YWxpZC4gQXQgaGlnaCBzcGVlZHMgKDE2NiBNSHogZm9yIGV4
YW1wbGUpLCBlc3BlY2lhbGx5IGluDQo+IEREUiBtb2RlLCB0aGlzIGRlbGF5IHN0YXJ0cyB0byBw
bGF5IGEgbGFyZ2VyIHJvbGUgYmVjYXVzZSB0aGUgdGltZSB0bw0KPiBzYW1wbGUgdGhlIGRhdGEg
bGluZSBpcyBtdWNoIHNtYWxsZXIuIE5vdyB1bmxlc3MgdGhlIGRlbGF5IGlzIGFjY291bnRlZA0K
PiBmb3IsIGl0IGlzIHBvc3NpYmxlIHRoYXQgdGhlIGNvbnRyb2xsZXIgc2FtcGxlcyB0aGUgZGF0
YSBsaW5lIHRvbyBsYXRlDQo+IG9yIHRvbyBlYXJseSBhbmQgc2VlcyBpbnZhbGlkIGRhdGEuDQo+
IA0KPiBUaGVzZSBkZWxheXMgZGVwZW5kIG9uIHBoeXNpY2FsIGNoYXJhY3RlcmlzdGljcyBzbyBp
dCBpcyBub3QgcG9zc2libGUNCj4gZm9yIGFueSB1cHBlciBsYXllciB0byBpbmZvcm0gdGhlIGNv
bnRyb2xsZXIgYWJvdXQgaXQuIEhvdyB3aWxsIHRoZXkNCj4gZXZlbiBrbm93IHdoYXQgdGhlIHJl
cXVpcmVkIGRlbGF5IGlzPw0KPiANCj4gSW4gc3VtbWFyeSwgbm8sIHRoZXJlIGlzIG5vIHdheSBh
biB1cHBlciBsYXllciBjYW4gaW5mb3JtIHRoZSBjb250cm9sbGVyDQo+IGFib3V0IHRoaXMgZGVs
YXkuDQo+IA0KPj4NCj4+IENoZWVycywNCj4+IHRhDQo+Pg0KPj4+DQo+Pj4gVGhlIG1haW4gcHJv
YmxlbSBoZXJlIGlzIHRlbGxpbmcgdGhlIGNvbnRyb2xsZXIgd2hlcmUgdG8gZmluZCB0aGUNCj4+
PiBwYXR0ZXJuIGFuZCBob3cgdG8gcmVhZCBpdC4gVGhpcyBSRkMgdXNlcyBudm1lbSBjZWxscyB3
aGljaCBwb2ludCB0byBhDQo+Pj4gZml4ZWQgcGFydGl0aW9uIGNvbnRhaW5pbmcgdGhlIGRhdGEg
dG8gZG8gdGhlIHJlYWRzLiBJdCBkZXBlbmRzIG9uIFswXQ0KPj4+IGFuZCBbMV0uDQo+Pj4NCj4+
PiBUaGUgb2J2aW91cyBwcm9ibGVtIHdpdGggdGhpcyBpcyBpdCB3b24ndCB3b3JrIHdoZW4gdGhl
IHBhcnRpdGlvbnMgYXJlDQo+Pj4gZGVmaW5lZCB2aWEgY29tbWFuZCBsaW5lLiBJIGRvbid0IHNl
ZSBhbnkgZ29vZCB3YXkgdG8gYWRkIG52bWVtIGNlbGxzIHRvDQo+Pj4gY29tbWFuZCBsaW5lIHBh
cnRpdGlvbnMuIEkgd291bGQgbGlrZSBzb21lIGhlbHAgb3IgaWRlYXMgaGVyZS4gV2UgZG9uJ3QN
Cj4+PiBuZWNlc3NhcmlseSBoYXZlIHRvIHVzZSBudm1lbSBlaXRoZXIuIEFueSB3YXkgdGhhdCBj
YW4gY2xlYW5seSBhbmQNCj4+PiBjb25zaXN0ZW50bHkgbGV0IHRoZSBjb250cm9sbGVyIGZpbmQg
b3V0IHdoZXJlIHRoZSBwYXR0ZXJuIGlzIHN0b3JlZCBpcw0KPj4+IGdvb2QuDQo+Pj4NCj4+PiBU
aGUgZHRzIHBhdGNoIGRlcGVuZHMgb24gWzJdLg0KPj4+DQo+Pj4gVGVzdGVkIG9uIFRJJ3MgSjcy
MUUgRVZNLg0KPj4+DQo+Pj4gWzBdIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVj
dC9saW51eC1tdGQvcGF0Y2gvMjAyMTAzMDIxOTAwMTIuMTI1NS0xLXphamVjNUBnbWFpbC5jb20v
DQo+Pj4gWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC1tdGQv
cGF0Y2gvMjAyMTAzMDgwMTE4NTMuMTkzNjAtMS1hbnN1ZWxzbXRoQGdtYWlsLmNvbS8NCj4+PiBb
Ml0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWFybS1rZXJuZWwv
cGF0Y2gvMjAyMTAzMDUxNTM5MjYuMzQ3OS0yLXAueWFkYXZAdGkuY29tLw0KPj4+DQo+Pj4gUHJh
dHl1c2ggWWFkYXYgKDYpOg0KPj4+ICAgc3BpOiBzcGktbWVtOiBUZWxsIGNvbnRyb2xsZXIgd2hl
biBkZXZpY2UgaXMgcmVhZHkgZm9yIGNhbGlicmF0aW9uDQo+Pj4gICBtdGQ6IHNwaS1ub3I6IGNv
cmU6IGNvbnNvbGlkYXRlIHJlYWQgb3AgY3JlYXRpb24NCj4+PiAgIG10ZDogc3BpLW5vcjogY29y
ZTogcnVuIGNhbGlicmF0aW9uIHdoZW4gaW5pdGlhbGl6YXRpb24gaXMgZG9uZQ0KPj4+ICAgc3Bp
OiBjYWRlbmNlLXFzcGk6IFVzZSBQSFkgZm9yIERBQyByZWFkcyBpZiBwb3NzaWJsZQ0KPj4+ICAg
c3BpOiBjYWRlbmNlLXFzcGk6IFR1bmUgUEhZIHRvIGFsbG93IHJ1bm5pbmcgYXQgaGlnaGVyIGZy
ZXF1ZW5jaWVzDQo+Pj4gICBhcm02NDogZHRzOiB0aTogazMtajcyMWUtc29tLXAwOiBFbmFibGUg
UEhZIGNhbGlicmF0aW9uDQo+Pj4NCj4+PiAgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1qNzIx
ZS1zb20tcDAuZHRzaSB8ICA1NSArKw0KPj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyAg
ICAgICAgICAgICAgICAgIHwgIDc0ICstDQo+Pj4gIGRyaXZlcnMvc3BpL3NwaS1jYWRlbmNlLXF1
YWRzcGkuYyAgICAgICAgICAgfCA4MjAgKysrKysrKysrKysrKysrKysrKy0NCj4+PiAgZHJpdmVy
cy9zcGkvc3BpLW1lbS5jICAgICAgICAgICAgICAgICAgICAgICB8ICAxMiArDQo+Pj4gIGluY2x1
ZGUvbGludXgvc3BpL3NwaS1tZW0uaCAgICAgICAgICAgICAgICAgfCAgIDggKw0KPj4+ICA1IGZp
bGVzIGNoYW5nZWQsIDkxNiBpbnNlcnRpb25zKCspLCA1MyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+
IC0tDQo+Pj4gMi4zMC4wDQo+Pj4NCj4+Pg0KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQo+Pj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QN
Cj4+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+PiBodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCj4+Pg0K
Pj4NCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFByYXR5dXNoIFlhZGF2DQo+IFRleGFzIEluc3Ry
dW1lbnRzIEluYy4NCj4gDQoNCg==
