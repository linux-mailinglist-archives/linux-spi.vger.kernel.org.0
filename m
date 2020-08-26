Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC5325291A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 10:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHZITq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 04:19:46 -0400
Received: from mail-db8eur05on2042.outbound.protection.outlook.com ([40.107.20.42]:24224
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbgHZITp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 04:19:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1dgFjqYPTXr+fKFGgCNIRkNnR0wXN/Zdlxa6EEnrtLceotD5h12teRKVSApLuChFD35h2nOQCpGn4DGkX/7BzAEqbN4mSSK0leXiTycdHwHXHctbmlnMGC7jhQLpPVK8I/CTwmSdx7sFIWm7rTFF1DaULphjHL9ZmcL41JFGMQoFxnRSFjPozNEdUvT46edRydNhyH+wL7AyzhWdgBLRFnqN4XpVwUTr3kJtmzElrSE+y3CLeLqsva8Sud8o90MxQN+QCJEcu9Zz+mrYQQkPHUe/tqbRmhYSUnzH4M+xzO5DuW+QsnNieyQaBKStJaXEIAWW3T/zRh+SUcmULbuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVw+2o0OAlcU+sKCNYc8HvDRLaJeIX2FQVBe7g5AqNo=;
 b=BQCRmG8LID45c+VmeZZMICNjf8cwOqq5E1pXadX5faTooegonWET7uChsMnQ6JIyOaKiqE8GtSR73k9dL+nPtv4pdypGkVlJ6+Tnwo+a4iwwvcMCV7B8LXQriHNJ9ax7BBBuhMb2zDLYBECtYmybMOenmOf8cdNlTS0k4aY2NpnutF2ZAtCLejcSaFk852J6oiAzAUEuAHnofQmAuxEYN4KmOD7qZAq2U5mbI5bVxZui0lyclnymJb29j82mnGspFbkXYaUmdzWSGLw1btkGXBiq1NmHNg1AGaQRrK3hyMB8cN88CSb6i9POsRY8xTZfPQueWzd7pCoD3meUOFK1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVw+2o0OAlcU+sKCNYc8HvDRLaJeIX2FQVBe7g5AqNo=;
 b=PO0uyq7dWB00zaSk6ylTbVudj5/84Lz+0/0WKpBYS6W2nYInv3dpWcpYZlv1pdVTK2RulC89tagIymU0KoU60z4HpuCZuNWI8672aGBL59EhFjo3HKcp0Yq0YnmVV9D4fkkbACC7u6uaidw3+U0akYVww2sWV/pH2yRoVn7nOq8=
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com (2603:10a6:803:129::26)
 by VI1PR04MB4077.eurprd04.prod.outlook.com (2603:10a6:803:4b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 08:19:41 +0000
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::9149:1826:669a:4d6f]) by VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::9149:1826:669a:4d6f%7]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 08:19:41 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>
CC:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: RE: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Thread-Topic: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Thread-Index: AQHWd7yts7Mn+npl8U6aqlpS6I2eY6lCmUmAgAGSXICAABSlAIAC4qqAgALvmNA=
Date:   Wed, 26 Aug 2020 08:19:41 +0000
Message-ID: <VE1PR04MB6768E050B97AAA33501B6D6891540@VE1PR04MB6768.eurprd04.prod.outlook.com>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf> <20200824112505.GD4676@sirena.org.uk>
In-Reply-To: <20200824112505.GD4676@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bd4e98e-1589-40a2-9c04-08d84998c816
x-ms-traffictypediagnostic: VI1PR04MB4077:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB40774CEE381715B0688DF16691540@VI1PR04MB4077.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vXBAdi7z2D1YS36T8IQXh5GBiU2ownLkOYhrK2DzuNnj9O5gl0I/BdNxdYtSb1QOjfakrAcPxUZ79gTHx6Q2rH6fxn/gDM0ZhmFhGZGNGJkzkmGO3xAqM5XFLbwGa/Lt2yMJUEB9vaOmEej8tWNaSm9qukd/AOz/UkPlNoYzfvssP0O0pV3n1fPBbnQnYghFDV37YcG85VIxMK86iFtjpBRrEgqgyncicjFpHlLlsG46n/l/Vx4fYTo8kUZ8OOtPgGhegOuYYIEVNr6RrlK+r8TxoqmzmU7QQiiNISS6LBepS5lpqWrRqm7iTFnHRPEp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6768.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(2906002)(86362001)(53546011)(6506007)(110136005)(7696005)(52536014)(71200400001)(4326008)(26005)(478600001)(5660300002)(8676002)(83380400001)(33656002)(55016002)(186003)(9686003)(66446008)(64756008)(66556008)(8936002)(54906003)(44832011)(66946007)(76116006)(316002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: b9KgcJkUaeTFde54fsiMpBZdGheFTpTyZCdZQ1dipKVLhNFcOuvYjCC6fBI9aTZhBL3lK2Hyzl7LirFWlM3KISDy4yqKWvi8ieMRDbq6CvyzAUBysKgc9ZV6lnurPck9JlL2JKUSRfY+lp1vZcMFb72N3VNUgx3QcU3CVkdEgKHYo6w7/qBZuuz1htUf4dnkdhB4fYcuFu7z3LX726r6D8NA9IcX6ZnSbBbNEkpLLCdiWQQL38x87taUm+Cq5GbdyhLzaqiqvi6mtEzHigida4yGXCTbHjf7z3j8NHHBbcp51MF3EOreDkHbAhQo3cNqLtad4X88Do2h8D7mNB+OIK8moOcWcFQI0nRYGNwY40/mD33bQNlLDReJJGyktohxLAAk5XsIaq+4sfSal3xXDh4f0O95WN5invi5QDrx3BXWZmjjJ6pt7gKkaDloCFEB2eYcITpEbY+fT7zF+DVzFjNZL1nvRCVq6EP4DkNXDAokepPZ5y5i9kdHvQ2tnjE1w3AdKoTx3qrYlJVFL/VJz+8Bp2PpKKlVV0xY9UpnWiwYjVxjRVup01XD/y++XWAoXrmLJAi+2KJweof2VPMyXCJFEcZZ53pJgCfzQU66Vr05yN8w9rf6HOOODO91aS6oyyZ3UjzpapYhegNC1Np4qQ==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6768.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd4e98e-1589-40a2-9c04-08d84998c816
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 08:19:41.2067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1+c34Eas45sUU7cO2JCXTJ3UUaQvSHC7kN+d2p3MjOfdViRCyB2zNRgslM5VtViS19MbhKQ1h8QM9DSssJwng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4077
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCk9uIE1vbiwgQXVnIDI0LCAyMDIwIGF0IDE5OjI1LCBNYXJrIEJyb3duIDxicm9vbmllQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBN
YXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jjUwjI0yNUgMTk6
MjUNCj4gVG86IFZsYWRpbWlyIE9sdGVhbiA8b2x0ZWFudkBnbWFpbC5jb20+DQo+IENjOiBrdWxk
aXAgZHdpdmVkaSA8a3VsZGlwLmR3aXZlZGlAcHVyZXNvZnR3YXJlLmNvbT47DQo+IGxpbnV4LXNw
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFFpYW5nIFpo
YW8NCj4gPHFpYW5nLnpoYW9AbnhwLmNvbT47IFBhbmthaiBCYW5zYWwgPHBhbmthai5iYW5zYWxA
bnhwLmNvbT47IFZhcnVuIFNldGhpDQo+IDxWLlNldGhpQG54cC5jb20+OyBUYW52ZWVyIEFsYW0g
PHRhbnZlZXIuYWxhbUBwdXJlc29mdHdhcmUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBz
cGk6IHNwaS1mc2wtZHNwaTogQWRkIEFDUEkgc3VwcG9ydA0KPiANCj4gT24gU2F0LCBBdWcgMjIs
IDIwMjAgYXQgMDY6MjE6MThQTSArMDMwMCwgVmxhZGltaXIgT2x0ZWFuIHdyb3RlOg0KPiA+IE9u
IFNhdCwgQXVnIDIyLCAyMDIwIGF0IDA3OjM3OjI1UE0gKzA1MzAsIEt1bGRpcCBEd2l2ZWRpIHdy
b3RlOg0KPiANCj4gPiA+ID4gVGhlIHdob2xlIHBvaW50IHdpdGggdGhlIGRldmljZSBwcm9wZXJ0
eSBBUEkgaXMgdGhhdCBpdCB3b3JrcyB3aXRoDQo+ID4gPiA+IGJvdGggRFQgYW5kIEFDUEkgd2l0
aG91dCBuZWVkaW5nIHNlcGFyYXRlIHBhcnNpbmcsIHRob3VnaCBpbiB0aGlzDQo+ID4gPiA+IGNh
c2UgSSdtIHdvbmRlcmluZyB3aHkgd2UnZCBuZWVkIHRvIHNwZWNpZnkgdGhpcyBpbiBhbiBBQ1BJ
IHN5c3RlbQ0KPiA+ID4gPiBhdCBhbGw/DQo+IA0KPiA+ID4gVW5kZXJzdG9vZC4gV2lsbCB0YWtl
IGNhcmUgaW4gdjIgUEFUQ0gNCj4gDQo+ID4gSU1PIHRoZXJlIGlzIHplcm8gcmVhc29uIGZvciB0
aGUgZXhpc3RlbmNlIG9mIHRoZSAic3BpLW51bS1jaGlwc2VsZWN0cyINCj4gPiBwcm9wZXJ0eSBl
dmVuIGZvciBEVC4gV2Ugc2hvdWxkIGRlcHJlY2F0ZSBpdCAoc3RhcnQgaWdub3JpbmcgaXQgaW4N
Cj4gPiBleGlzdGluZyBkZXZpY2UgdHJlZSBkZXBsb3ltZW50cykgYW5kIHBvcHVsYXRlIHN0cnVj
dA0KPiA+IGZzbF9kc3BpX2RldnR5cGVfZGF0YSB3aXRoIHRoYXQgaW5mbyBiYXNlZCBvbiBTb0Mg
Y29tcGF0aWJsZSBzdHJpbmcuDQo+IA0KPiBZZXMsIGl0J3MgYSBsZWdhY3kgZnJvbSBiYWQgYm9h
cmQgZmlsZSBjb252ZXJzaW9ucyBhbmQgc2hvdWxkbid0IGJlIHVzZWQgYXQgYWxsLg0KDQpJIHNh
dyBhIGxvdCBvZiBkcml2ZXIgYXNzaWduIHNwaV9jb250cm9sbGVyIC0+IG51bV9jaGlwc2VsZWN0
IGRpcmVjdGx5LCBzaG91bGQgd2UgZG8gbGlrZSB0aGF0Pw0KDQpCUg0KUWlhbmcgWmhhbw0K
