Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A2141B127
	for <lists+linux-spi@lfdr.de>; Tue, 28 Sep 2021 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbhI1NwC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Sep 2021 09:52:02 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:3484 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240949AbhI1NwB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Sep 2021 09:52:01 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SD9qLR018400;
        Tue, 28 Sep 2021 06:50:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=U6Zm6ov9b0hjkl4U1mTRpgy7XzqyRHrjJc7oXk5TpaU=;
 b=V52mfLSuy9E2anYsxnZeLqepRiwbGVYF0CFgywbmlTNh9RGamOTaLCCbRbb0E55GW6FP
 VE+g2RRy6wKlm9ji12jiScwaoFdftEjkP/ZehWrZueuB6mSBLHQcoJ/7vLZ2Fcnpuvlg
 fg8J7h1YRDqkMr/59oe+ADUopDS01qbPNrGrJoDuXZtBjJdkFdJvDMmJSpf6y/yep+XE
 MpOGF3cmZOJdOD9nZknKgwW3JhkJFeJeGQ2UH0BnI3kkfQ6cqpEQoWNlUclgopfsvrw7
 gQV70EUMJ0cUfFN+xfHnjlXP/QUFOphV+rogjl5ifufJriuT9KwSdWFDObhHxA2PF39g Vg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3bbd5am07q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 06:50:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL9PmBrvTbN/QjTkIhwKimDK540FyiXL0qLF3gDC87hEkEFpTomLX6jkpvpK4f/xwCBS5Igz05ROQ1reWSfxxZizjWl9ao76IC04GX8XUtlFwDmzHGW8bzh3jcVS7pEpWScBF4S1b59wnnjWSxRAN+Ya76HZoGYbTKQKiV9WTh0yYnaWCAI1Ca2S/zYwEmogmMDpgSA8QvKLNOPIZ/C4KEUEFkgeNZGcWDubBij6sybyUjuYIFz6q+0NoqB9UlKn23Wp4pkZ7HEhmO5DYCq+X9OYz9seR/R2ok7pI4tkBKziksG7OP7fVv726+Z+dLQ53eJ/J1cMeEoY89iimbyhsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=U6Zm6ov9b0hjkl4U1mTRpgy7XzqyRHrjJc7oXk5TpaU=;
 b=ebj7Y6yDCG9xVnM/IHw2A3nyKeaJjWYo66IodszLTf4JgNpZGrcZjBtl5yCZajY97p/W9HIFkyKBb8nQ3Rt6kfqwuvTPD2tBXZ3Ylj9YhtfWf3x96nwpEWtTuNwasWm7jW0ulhMC5vnGA2haAcgDXVXXiFykEsnPsvn5pKDILKHdeZtql41kHIc31mfS6W9g1quiZ4KQH/K/DezvkckpkGav6KmgTcjecTlG7ReCwpVvrMIrqBKqfDxb8sZwknd84tw7UhGqOrL87bmGL1MdqBSgu0sSMQucft7gbzXX3fmwYj+YZZRU4tJcrH885CISRoTCMttt74BJV5lfGabrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6Zm6ov9b0hjkl4U1mTRpgy7XzqyRHrjJc7oXk5TpaU=;
 b=zJg84MtZLbcL1vtQYboVh+gl16NcWbEZ5sAULMFNuiH+PckrGE81lOQxEu/QAuH/pci9amNQ1YvgNcHwLrIdww/D7z55dd92D3tzjTag1v044dhchDCwlmX/Xj7a6ejYqY7j71ijek+g8qp8pMEdbp5anHGIGqgDXl1hAaKnksQ=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR0701MB3684.namprd07.prod.outlook.com (2603:10b6:910:93::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 13:50:13 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87%3]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 13:50:13 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Colin King <colin.king@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] spi: cadence: Fix spelling mistake "nunber" ->
 "number"
Thread-Topic: [PATCH][next] spi: cadence: Fix spelling mistake "nunber" ->
 "number"
Thread-Index: AQHXtGnJbUGtDldj302Xly2408Dt86u5dWnA
Date:   Tue, 28 Sep 2021 13:50:13 +0000
Message-ID: <CY4PR07MB2757C6D70017C861625022C1C1A89@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <20210928130712.990474-1-colin.king@canonical.com>
In-Reply-To: <20210928130712.990474-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1mZjYzOGE0MC0yMDYyLTExZWMtODY0My0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcZmY2MzhhNDItMjA2Mi0xMWVjLTg2NDMtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSI0NTciIHQ9IjEzMjc3MzEwNjExNTM0MDE5OCIgaD0ib1FkVEFYYWZoRnVVYkZOY2NwWFB4R0tGeVY0PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fe5259a-fdd1-4fac-742e-08d98286e577
x-ms-traffictypediagnostic: CY4PR0701MB3684:
x-microsoft-antispam-prvs: <CY4PR0701MB3684BB7BA9E7E693264703CCC1A89@CY4PR0701MB3684.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PqxXZKzRClUQzYJCSp0u665phDMtdYBl24QsyWe1uGVzvfqjH7b615Lq863QcHpr+cDihHABPa/jGsAu8hsNYLfCA9cwJSS+ZfIj3Ks1HOZPX4kCYpMv/atEvu07l5zTyoTQsouKLL+6QkVY3EcwVgXdNySIefeqKeFtBnQYA2vTnlguroT701unXIUjwPxCfJQgqMQczoxKZaLyxaSowjBL21YaWv0vkaNUQYwzKD7BvmTAzvwqTKsi0EADh0eV3eXyPfu0mgQPb537PRmMdtbdoRJKSA7KT2DS8+DPuByoJaoY68ckUpXbzFkNxYjplAdvy7iII2e/BXvmR2iLekoHEDXPL/zVwXHDZampx0YYwjr12F78gdcvQ/Pb7jJWzgDaQMxO4HzHU9boiSz9fTaYBMWjCf3PkO+VSSGmcFYNzYiJ/ITDaF6Weot6T+AiUSYLG+/GX9jkNY/BYGGqDtcxqtfv55i1hvZEKPy/FpX5AIZ2NnrNAy8pGH/97nnP9Pw0/G73noyZBz+1Co+mo1mhaJibydoxbuzCIi6UFiyBwZPV3MUrQkU+qLUpmpnhn47zqaGOx7ByUMB2oDACflCMPEvjKuz5xQ9JHc/sTlIubJvOOzBPUT4aMubw9ideeyvb7czwbra6HrZslQTd3knH2lc548Hu6cNkp95Y/QQIXIHRSxadPfjeckKJRn2Fffk+IRe4x8qKg3SGbQHPGDplj9/sizVOKPE12KdRxb31y+abNGFtfSjYYqr088+9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(66476007)(66446008)(33656002)(55016002)(66556008)(9686003)(508600001)(38100700002)(122000001)(5660300002)(2906002)(558084003)(52536014)(7696005)(64756008)(83380400001)(86362001)(76116006)(26005)(66946007)(38070700005)(54906003)(8676002)(4326008)(71200400001)(186003)(6506007)(110136005)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clZVVkhWb252N25aNUFqdjE3V05sN3h1NEVsaGNIU3A5cDBLM0xzdW5oUXlH?=
 =?utf-8?B?MW5seVVRcFdNLzhXVjEwOGhDeWs3MXhwVEtxOWkvR05MQ2VNYTlkVjM0SzU2?=
 =?utf-8?B?MGZVd2RlTEJ1QlN6RXN0VVkvb3phTlZHcGZiYWU3UmpwME92dG54b1o3WktO?=
 =?utf-8?B?K3IwakVNcVRRME1VRFJ5SklWb213WEhGcnExOGNiYnJlcHpiWFdoRWppSDNJ?=
 =?utf-8?B?akRibTVxYWEyaDRMbE5BZk9DRzlablVPdEpTR2o2aGtSeDhsZXhUWm4zaGR1?=
 =?utf-8?B?cE9iTEVPYUp5WlhXdnRyZ0VXRXB2UCtJNFVuUUlQWTFJTk9UL28zdk82RVVY?=
 =?utf-8?B?Q01rbThvQk1QWi80T1U0b3VMTTJYRnpCckZlRU5rblBXVVpmUkpreXZBMG5v?=
 =?utf-8?B?NXpPdlZ3VDAxd3RiSmlvS2FMaEQvYTY2QXRHSVE2Wk5rUjc4RGU3VnJxWnc2?=
 =?utf-8?B?SG5RM2xjNlhsMzVUWFlCUVdLYWs5YXpRcHUzbjBwd1FJamF5bFcwdVZxMHM2?=
 =?utf-8?B?UFRJVG1BUTM3V0FwZFZiOEFWYS96dEt3WW9QSmJ6RlpvSG9sZjk2ZzZxMFZr?=
 =?utf-8?B?VS93bVk0RHZLOFhzbit2WXlqdUVBVnBieitMQ3RpZm5tRGI0V3VGTU9zR0Fs?=
 =?utf-8?B?T0hJRFo0T29yc0lQVTRoN2dEMHh1NkcyUWEwN3o4MUUxVEtZN3ozQndKTEtH?=
 =?utf-8?B?Y0gzazcvU0RUR0RpTEdjbkRkQ0drWHpEakY4UWluQjdkenluM0EybDU1ckVS?=
 =?utf-8?B?Rkk2cERtU3U0TzJiQlNMM1ZIaUNMUnYyOFp1N3N3Z0tPaWVGVXNSTjhJdmZV?=
 =?utf-8?B?UHhZZEpJeWlFMXEvWWViVXcza2lvTFVTNmNRL1puOXZUVDVjWVZyMkwrZWV6?=
 =?utf-8?B?NmlpK3BsSTBRV2ZyWU14dmpiREh3bmQ4TnF5QU9HdCtuVDFHd04vcjJLa0Js?=
 =?utf-8?B?dWRzL09GbzFjcTEwNUdlU0tXMWlWbjVvNFRuUnpKYlVPUytleVNnRm9PemxE?=
 =?utf-8?B?WE8rbkNTVkFURGluVWdESzF1MGwwWlBOcTNoSkV3dUNONGtyenRYTWh3cDYx?=
 =?utf-8?B?a0cyWlNmd2JRNTdxc0Y3LzhXTzgzMTRzbHBka0tRN2RheFdURVVxOEI5eTRk?=
 =?utf-8?B?WWMvQmM5alQ1akZ2U09DL2g3ZXcrSWRMWGlkdk5QSWYrb2ZsRjlLc3VUSWNV?=
 =?utf-8?B?eEp6VitNZ1QzVEZjU1B4MU5BK2hDTUZEbE9JZkVCWitlcEd3SktiakxQNGtm?=
 =?utf-8?B?VU10RWhnMnd0ZEU4Wit6Rlh1WERFR3JGTGxldm85REgzSHlCTHQ5b1JyU3lB?=
 =?utf-8?B?OGNyWlVkNEFxa2F2c3c3bXVscXYreW9uenpLaFFIb2lyWGZuVlNIdjA3Ykd6?=
 =?utf-8?B?TTlQOFRhT0NTS1I5Z0wyRWNzMXJGYzhkUEFSemYyZ2FEbmcxWUcyS0lwVmw2?=
 =?utf-8?B?NWplVmxkbGtrR2FjaUVEVlVTYnFhM2Z3dWlqQUlUWFNuRWtMeTlRK2hscnNt?=
 =?utf-8?B?R3dvWGpFZE1iVFB6aFJiM3dVSnhpVGtPeXErYzdLdExlQm5hSi9yRkh1UE9p?=
 =?utf-8?B?V0sxT2Q5MG9Lem1PU1phZzFSYy9uNU9MWVRMbWxTU1hVbGNyNzg0OEZaeTV5?=
 =?utf-8?B?NUlnTUlxU0VVY1ZIN1NkLytkeFNtRXZHOWpvNzhHUW9yQVBNTnd5VGZMLytj?=
 =?utf-8?B?aGpkSlk1N3NkakdZeHg0dm5UTjcyM2R1T0p2eDNlSDA4d280T3VuMzBUbmg5?=
 =?utf-8?Q?9YdsNrSM6hmI2yCQWM2OIo27icrYrrwPva5cNZr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe5259a-fdd1-4fac-742e-08d98286e577
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 13:50:13.5096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8cRW/JFiicmS3TH27vU0KWe+dKW5WA1qrW0PH2fEJQf7b7QdTJf5cUgjP/rWrL/j3A2ZOvHvFlUVuZ+G6q3TN9FghpSHXrroXrLBEl3X2M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3684
X-Proofpoint-GUID: qoOOAFpIZzMg91UCPeGF-Nzb_9heoQHb
X-Proofpoint-ORIG-GUID: qoOOAFpIZzMg91UCPeGF-Nzb_9heoQHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=833 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280079
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

VGhhbmtzIGZvciB0aGUgY29ycmVjdGlvbi4NCg0KPlRoZXJlIGlzIGEgc3BlbGxpbmcgbWlzdGFr
ZSBpbiBhIGRldl9lcnIgZXJyb3IgbWVzc2FnZS4gRml4IGl0Lg0KPg0KPlNpZ25lZC1vZmYtYnk6
IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+LS0tDQo+IGRyaXZl
cnMvc3BpL3NwaS1jYWRlbmNlLXhzcGkuYyB8IDIgKy1bPl0gCQ0KPiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCg0KUmV2aWV3ZWQtYnk6IFBhcnNodXJh
bSBUaG9tYmFyZSA8cHRob21iYXJAY2FkZW5jZS5jb20+DQoNClJlZ2FyZHMsDQpQYXJzaHVyYW0g
VGhvbWJhcmUNCg0K
