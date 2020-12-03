Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBA22CD7F8
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 14:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgLCNgb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 08:36:31 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60558 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437200AbgLCNgY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 08:36:24 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B3DYdck021609;
        Thu, 3 Dec 2020 08:35:43 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 355vjensuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 08:35:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ntgl41QYCLm6KP7ghTEEej6zxdb4ppSfJ7Ub2KA81KvAzFG980vK9B57G5BBYjGS26vft4kh8Utv+d/HVIn2SkKTAqJSEvt0VQmtTw0J07SOL2opWtVNt+ufuannts7vOv35Rkd4Y9GSH2CEfxdatKrVxAohpNMQbXyEUoVb6le393W0hoLbpCKD/Mk/5B6gWDNf6mzkjPm4o2aMYxTEju3D6b8IuoaxPOuLTx+KZF/ZrpfSQLh4I5dt7z8nzB/REy2/ZYR7zsJkiRIMnJh9t98Tht7rTyWTzBifQ4Wpc4bq/VRoKuuv4ytzmhPk7zA7BXTxfRadl4rPZYsVuuPftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbkpRiMrHJAd4r6z0li7M8WPBnafmR600x5fc1OHmfQ=;
 b=OIpaIy3GUzSyiYrejhzlJEqEI3DmGRlRMCLySEV2zGs64tCOD3Lfqkp1ocGm/XqgigEswAlzPYlPMqMPPSvp5oi0/veHrgJoioU4fSwdYaSZOTDnzkIjbRnac/mi/erUkPnCo7FbkUKWysWwGzYHylCcvmVm+1dIBEywnTkzixScnQEoRPt42cmqoKuY6awW9ETZahQlkwuQShFiOmklbfWEGTQh88/ZHKEXFU50IL5LKRN0A0+emJrE/2LJamApfok5NZbW4hY5u//uMSa4d0fv1LoLbmdaivVpGPOeRco5aaoEr54HDr9Ia3IsHhVHzU/JcKrkb0kijfDhFaIQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbkpRiMrHJAd4r6z0li7M8WPBnafmR600x5fc1OHmfQ=;
 b=3lbImQkfFF8W/LbqgBh02/J7OswYsamm0qGdWEFAI7iWPa47QEF9AMUI1ZxbzwsGKjanMnH15q349ticiiWUxihWRO5k2EOeS2Od+GPyDEfb4GuJVD6ccTYv+LOV85qIqq+we5O/DBTU+9uylZLcPEjfZz5JonC8SzhqSTINs+g=
Received: from CY4PR03MB2966.namprd03.prod.outlook.com (10.175.122.14) by
 CY4PR03MB3303.namprd03.prod.outlook.com (10.171.244.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Thu, 3 Dec 2020 13:35:40 +0000
Received: from CY4PR03MB2966.namprd03.prod.outlook.com
 ([fe80::a45b:c565:97bb:f8ea]) by CY4PR03MB2966.namprd03.prod.outlook.com
 ([fe80::a45b:c565:97bb:f8ea%4]) with mapi id 15.20.3611.025; Thu, 3 Dec 2020
 13:35:40 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH v3 3/3] spi: dt-bindings: document zero value for
 spi-{rx,tx}-bus-width properties
Thread-Topic: [PATCH v3 3/3] spi: dt-bindings: document zero value for
 spi-{rx,tx}-bus-width properties
Thread-Index: AQHWxL5x/SzIkvuBHk6tpLFHF/0ayqncCQCAgAlfw9A=
Date:   Thu, 3 Dec 2020 13:35:40 +0000
Message-ID: <CY4PR03MB296675A9663E590604B0944AF9F20@CY4PR03MB2966.namprd03.prod.outlook.com>
References: <20201127130834.136348-1-alexandru.ardelean@analog.com>
 <20201127130834.136348-3-alexandru.ardelean@analog.com>
 <CAHp75Vcm5-i+n2dS7GxqK8Rp74+Y-+5CdMoBNP7ZCXkw1VnPkw@mail.gmail.com>
In-Reply-To: <CAHp75Vcm5-i+n2dS7GxqK8Rp74+Y-+5CdMoBNP7ZCXkw1VnPkw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVdGeVpHVnNaV0ZjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAyWW1OaE56YzVNaTB6TlRaakxURXhaV0l0WVRWa09TMDBNVFUy?=
 =?utf-8?B?TkRVd01EQXdNekJjWVcxbExYUmxjM1JjTm1KallUYzNPVFF0TXpVMll5MHhN?=
 =?utf-8?B?V1ZpTFdFMVpEa3ROREUxTmpRMU1EQXdNRE13WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhNelE0SWlCMFBTSXhNekkxTVRRM05qRXpOVFl5TlRrME1Ua2lJR2c5SW1J?=
 =?utf-8?B?NVZVaDFMemhMYm05VlVscEVhVEJYWW5wUVFuaDZiV3hDUVQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUW1KelEwbDFaV051VjBGYVkyc3lSSFUxTlRkbk9X?=
 =?utf-8?B?eDVWRmxQTjI1dWRVUXdSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlozTldNRFJSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: true
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.131.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d88bf7af-1835-42a3-7224-08d89790535f
x-ms-traffictypediagnostic: CY4PR03MB3303:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB33039DE2420E06F513C25E51F9F20@CY4PR03MB3303.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0nARTOfhQIssyHSs1piWgouY/dHis2so72Q1PPfhJsdw4nTtIIVrmQWKYB4Kazjrj/3rYgJGnY29FMThpl71A9w8gNvVLdRXbwgb8gEhmfVLVF7N+X2RY7RWjSsl8nyNkFDSulpjN0HWskG9ISrq2kqqyAbWKv/Hfz2v6qNn0NK+zyMfxsLjEy6O48A0kkSlmVZ6bhInnv9TDlvRcHAtkaDJql1Fcnz5P7jubOh+v98LWaJtoAqkse1p6rx7HDJaOlwU/vdjowVtFDFLcOtz8+wHAL+5+c9YfVVw8w9FkVfESSsqGvF2xO0pNlh67PI4XwfaMr1DFdJpUxmML8z64A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2966.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(4326008)(478600001)(9686003)(86362001)(83380400001)(55016002)(64756008)(66446008)(66556008)(7696005)(54906003)(186003)(8676002)(52536014)(4744005)(5660300002)(2906002)(66476007)(76116006)(66946007)(71200400001)(107886003)(6916009)(6506007)(53546011)(26005)(316002)(33656002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RGZsVklxZUhEYmJKb3IwZlg1bXZTVk0vR0UrNnBrZ3B1Zmo1TitCMFUwRW83?=
 =?utf-8?B?bk9pSWlIRjUySHo4alQyQ0V2SVZnMnc0YmpHdVJpb2tWQThQNWpaaEZvMVU2?=
 =?utf-8?B?bllhOW5ITndaSFpCZkZFdEYyQ0lESkd3YjIyeC9DR29uL2JqZGkwWlAzY0pk?=
 =?utf-8?B?ODh2NENnWis2cUttaDJQWTk0YlFKN2h1OWJFZWRodmhFMVpYUTVtb0x5WmlQ?=
 =?utf-8?B?YSsxRTEvd0tQVGN2UDN1T0JBcUNycGFvdVFKNjFlZGthQlFHcHpKamVzZ0Ni?=
 =?utf-8?B?RzZMQ3N0THk5MzJ6U3BhUndjNWtrUzh1QXhNZHhPcVlyK3RLeHU4Q0ZCU1NP?=
 =?utf-8?B?dG9xdHNWMmVXRE4rS1hmM0dKSE9sajhTeUxPVGpIT294MlA0WXZTM0JFd1Nw?=
 =?utf-8?B?N2JOSXRvd0ZHY1AyWFN6eWtxNUlPNHR6VzN0bXB5K0FGNjFYQ0I1VlJ0VEsy?=
 =?utf-8?B?dW5ob0J3WVhYWHNTQnFYa3pRQVpYU1QyeVNaRENSRERKSFk4clFrZWZyZ04x?=
 =?utf-8?B?cG4xZlZzTWd4WFg1Z29vYjZNbkhIOE82NFBhcFhnWEplV2huMndEcXRqTCtP?=
 =?utf-8?B?VDlHM2x3VlVjcSttVVh2b0oySEpad2RrQmYyTFhvZWQyREZmQ2FCcGh4a1o4?=
 =?utf-8?B?cmJrRHh0L3lPUy80MXpGOTBkclBWZUhqV0FYcTN2ZDB2VTN1T3NZWkY0Sk12?=
 =?utf-8?B?WWdXVGhqN1J0dGVGSEd6LzBMM0ljKzZRUmFuVDBrTjR5ZWlIcGpRUWxPTGYz?=
 =?utf-8?B?MlhoblJxR256OHNHd2NpemtBNG12ZHMyY0FCSTJIaFBtYjc0b3pudVUvUU9M?=
 =?utf-8?B?Yk9MeDdYc1dYTUVPSHdCU0prUnlud3dEMUxvSm1NZ2lXbSs3UHZhVWU2ODU1?=
 =?utf-8?B?Z3VFRktjcmtuY1ozZnJCK0xyZSswSTRpNVFNU0p1ZE9HMDF0dE5MOEVGNU4x?=
 =?utf-8?B?ZldEcjUwN0tqTWhIUzI0a2VWYWZCSTlheDRHZ1F6SDJuZUN5dzdKUGJvbTh3?=
 =?utf-8?B?TGFrZnptNjRVTi85R0dndWx4dkFBb0RwVnZ1eE5BTlhRc1Z2MjdlN2FUMXMr?=
 =?utf-8?B?TElMODlLTitmTFBmZU0zZUpaUjlKZ0d2QnNPemZXR3h5Q3dvbm1EM2pmcEtS?=
 =?utf-8?B?eUZrQnRIMHR5NkNBakNDeGdqSFVPS0swU25ZYW94MW1jaSsvWHNKNkYzN083?=
 =?utf-8?B?MjNYcWtvU0hBQmpKUmc5dXZjeW1RS0I4RWNHUnFudlRmOU02eFpqdmswRGlK?=
 =?utf-8?B?UjNXVzZ1QzRHbDdNeUtmc1BUc3NjQVFUVnE5d1ROcmovcExRZXk0NEJsKzdV?=
 =?utf-8?Q?hYFw06nw1LnmQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2966.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88bf7af-1835-42a3-7224-08d89790535f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 13:35:40.1024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/EOAOTStvIsr+Qe0GFAGAvv25CTpf6obJdBqL7udY6zlwDYagEylIjY9FKP9IJfd31dk0V67K5CXnOMGMDJR8rA/j4n20lniNMSJDkD92w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3303
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_07:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=916
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030082
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDI3
LCAyMDIwIDQ6MjYgUE0NCj4gVG86IEFyZGVsZWFuLCBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRl
bGVhbkBhbmFsb2cuY29tPg0KPiBDYzogbGludXgtc3BpIDxsaW51eC1zcGlAdmdlci5rZXJuZWwu
b3JnPjsgZGV2aWNldHJlZQ0KPiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBL
ZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IFJv
YiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIEJyb3duDQo+IDxicm9vbmllQGtl
cm5lbC5vcmc+OyBCb2dkYW4sIERyYWdvcyA8RHJhZ29zLkJvZ2RhbkBhbmFsb2cuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYzIDMvM10gc3BpOiBkdC1iaW5kaW5nczogZG9jdW1lbnQgemVy
byB2YWx1ZSBmb3Igc3BpLXtyeCx0eH0tDQo+IGJ1cy13aWR0aCBwcm9wZXJ0aWVzDQo+IA0KPiBP
biBGcmksIE5vdiAyNywgMjAyMCBhdCAzOjA4IFBNIEFsZXhhbmRydSBBcmRlbGVhbg0KPiA8YWxl
eGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRm9sbG93aW5nIGEg
Y2hhbmdlIHRvIHRoZSBTUEkgZnJhbWV3b3JrLCBwcm92aWRpbmcgYSB2YWx1ZSBvZiB6ZXJvIGZv
cg0KPiA+ICdzcGktcngtYnVzLXdpZHRoJyBhbmQgJ3NwaS10eC1idXMtd2lkdGgnIGlzIG5vdyBw
b3NzaWJsZSBhbmQgd2lsbA0KPiA+IGVzc2VudGlhbGx5IG1lYW4gdGhhbiBubyBSWCBvciBUWCBp
cyBhbGxvd2VkLg0KPiANCj4gdGhhbiAtPiB0aGF0DQo+IA0KPiBJJ20gd29uZGVyaW5nIGlmIHdl
IGhhdmUgYSBwb3NzaWJpbGl0eSB0byBzdHJpY3QgdGhpcyBmb3IgY29udHJvbGxlcnMgdGhhdCBh
bHdheXMNCj4gZHVwbGV4IChJIGFzc3VtZSB0aGF0IHNjaGVtYSB3b3JrcyBpbiBhIHdheSB0aGF0
IHRoZSBnZW5lcmljIGJpbmRpbmdzIGlzIG1vc3QNCj4gcmVsYXhlZCBpbiBjb21wYXJpc29uIHRv
IHRoZSBkZXZpY2Ugc3BlY2lmaWMgb25lcyBpbiBjYXNlIG9mIHRoZSBzYW1lIGJpbmRpbmcgaW4N
Cj4gcXVlc3Rpb24pLg0KDQpObyBpZGVhIGhlcmUuDQoNCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBS
ZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg==
