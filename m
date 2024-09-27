Return-Path: <linux-spi+bounces-5006-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A3988160
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 11:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D211B21831
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 09:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D775C15ADAB;
	Fri, 27 Sep 2024 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3lnUrRxW"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E1328EF;
	Fri, 27 Sep 2024 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429466; cv=fail; b=ayKF31VRoYCypMg6nyElZtaZxPsrf97/GAKisFhOotFZ3l1S+fyS6BkGJhcspq4uxnN/6Sp/m+gfblynuMNuWZshZiU4IKDLgAz9uTnMrKlqBYpHZkgP+MqzW18ABP7Y2loFsfSTn73rImQepw+DgsKqt33vuDE8GmAzTd5ZQWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429466; c=relaxed/simple;
	bh=Cnlq9ozOAbbzCEVI80MHZc9G/PE5dGCH3payCXjLQPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aRXD/RPyHC3V1YRjJLGX3VFVR5G9FVvy5Jd/xAguE2qspWGylmEBEBjH+c7/72RmMJ7TrQKGhBaSSeD2APiSkuSTIxjiNgcAEx/VO35DOMIBTYhoS1gaI/ifcSawzWeie8RFD+3iWqYH1rBdq6sUmissOybZttHnZZmEw3Pj+FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3lnUrRxW; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRLX46925vZGG3znZhrqHfKCFJW4BGW3uFMa2vtq1LtoExU8RXLhfi0rSIS3v7CSb0jx7zLTDjRfdenjz/zFLuDhvaVgEE+1XpGH1BV3wHu3WQqsjFHjmIU7+yh78cOWmfXVAfolUh89v3U/wKHavozJf7nEdU7TLRzb7RZkqBNwByzKza6oSy5ui5jdH938KQjUe1VnH1wVkAhmL3E3dy4Lv6Do0BWmcQKHYc0ZNBoW2OXnG6EAGsgYQzWGSisUQiFCi8ypfkuvYxkqJy4rmN8ooNEZYIrdXEjbCyP9XOTWIV7d6F2mYhnKSggn8ev16UJ4BQKBIGRGyEFd6CaoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruz7ZI9yYEa76vJ/ovqCGT/KNxqnLETBNDJnuJM0TJs=;
 b=mr5rkH2I8BkCWKo+p5hQBP7C3FS4Wby5OAHz0O/nBZCPRMH2CXavEFc81yc07par4jQmtnRFRl+/WKGcQD1zd2I141JBcHprL3px7l02kgd505rAn7/B0O8TuEpDcfmPuGhNUoa16REvojW8JvFtuTCt60StOEamyTjhwFa27sFmS7lTw2vZBYRE4b5jHnnkh6DpjEw38DilrDF3qEeTMNapU/yJDSfneHRyUPslNYliYH5JVatw9qBm88wdPdmSAcubbOuhPoAXTRjwrLgShViSGRnpB8zEfQ8L17hTIwH1FZBW0/4eq/scC4HKkIH9QARsbvLfVbfyfQEUy12doA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruz7ZI9yYEa76vJ/ovqCGT/KNxqnLETBNDJnuJM0TJs=;
 b=3lnUrRxWbcyfGhpBMagr+yB/eaWrBjAEPbE5KWPil9Rol4N49gtIpIVecZuFwXPUi2EzaYAX76Vz5qGvH9rPw5kjaWIToxe7sedDXbqor6+2WVfWLgMVJseY8eN1qnquxYs/lZB+QtQQCTIbFqnVD+EWV9HRVwyXtUU4OWLej+E=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 09:30:58 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 09:30:58 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Conor Dooley <conor@kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names
 properties
Thread-Topic: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names
 properties
Thread-Index: AQHbDbS6IWXQrG+wX0CC5AjhvyS/qLJnJHoAgAE51XCAABg2AIAC3+Pg
Date: Fri, 27 Sep 2024 09:30:57 +0000
Message-ID:
 <IA0PR12MB76999B696A9BA0834644AC71DC6B2@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20240923123242.2101562-1-amit.kumar-mahapatra@amd.com>
 <20240924-impaired-starving-eef91b339f67@spud>
 <IA0PR12MB76998D7BC3429606508E6202DC692@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240925-trapdoor-stunt-33516665fdc5@spud>
In-Reply-To: <20240925-trapdoor-stunt-33516665fdc5@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|MW4PR12MB7430:EE_
x-ms-office365-filtering-correlation-id: c60ed0d9-09d5-4499-73a4-08dcded717e2
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gmzIu0Src2Ku4xq2VMXdktYIM5jCzv3D1FSltGt6DRwkQ/z8qDxykzHFWK87?=
 =?us-ascii?Q?qAvfBxkciC53gBDupe72xeI6MXfRKN0c/HkSK+rH7XZxpCmsj3gvy1j+SeVY?=
 =?us-ascii?Q?NnrNLUZsFvHB4+15hemEBvTZnLlDRHWWIcyzVPiV3sYjWqpiipVKWTPCDezJ?=
 =?us-ascii?Q?evwWPCKBN9h7TuKdBSrfT0BVFviOvMVkEXnXOI92hGGflwjx4wilJGfIgh2R?=
 =?us-ascii?Q?6U30xgvglufDNYDx1yWF3cj11w8159qM8UCYQI4fN5/O8nSpDqUkf7i+uMfH?=
 =?us-ascii?Q?5WsSb/8WG19SOtEBXMJOQYZ1C+fRT8P6zIQFbLgGQMe2r3/iFbjnrGW9KjlA?=
 =?us-ascii?Q?BYpBmcXHzwPlQh4LvD9qjtE18PDnQBLs1ubw010XUfKODYt5z1Pf1qjnN69z?=
 =?us-ascii?Q?V33qu6U7YSKPG8jXfbCxh2AgVlFb5ktb3xqRlEKYR3TWlwkH9A6yo0ce/ola?=
 =?us-ascii?Q?u5JF3FNSxx3l6xmQkpGznh6EHku+8eH3Si/jQytstvt8WlfjRxZfcga4aU3x?=
 =?us-ascii?Q?nT4xW4qJI9iHGNkCLnRInrfKi3lxcaJDpSWr36qUQsUgowpLEm3fyQ2Czkkl?=
 =?us-ascii?Q?PWgT+bMsSb4nUNwSos9+IP5+qbE23kKaSDVLYABjPJl2pTeAu/gGZXthya6P?=
 =?us-ascii?Q?UbXuylQu/H7yRnM6YKBd7nN4JIfL//ve3ruEgDlHZVwH+dVAcUd6RFgYTTV/?=
 =?us-ascii?Q?Um+PrRgwab+/WoPUkGB/xVWbq3OOaom9pkbD7kwKap41a643nTMChr9AcKFy?=
 =?us-ascii?Q?g63LE2AEUqoutV+Jg3AZA8vbXb9CaF+s8XOHBfZnWFO7WHXgvgTbVW/fa1id?=
 =?us-ascii?Q?94W0HXMr4wxOwtOeCIs95eCV73wZ1Imv8ASJeA/llgBSk59j8ixfGcEEJyvg?=
 =?us-ascii?Q?JsAnOrANRwhcB7wN9zWCq8kOXSqSjWK6xbcu/OBSCwZ9LHnrM7HE38oK5pdM?=
 =?us-ascii?Q?1a4h2zhHALkgq+VXBMUdGZ/J2Us3A7PO+aUXYw8DoBlD3QfQ7IcFGUAFYoJT?=
 =?us-ascii?Q?bZB4XK8pqM/qzOVbvgzFjErkQct00phLbNNbRXr8GVpREIPCPOjvRdoX3Gi8?=
 =?us-ascii?Q?JFEmoUn+g8bMpytuHZtJ3V8Wn7q2deJytoS/dzecl76a6tkv8sqadd193BJ2?=
 =?us-ascii?Q?z5A6fk6Nw/B7gtMw1hK7EG9DgnpITO2Z9a4YXkORdmnK4wGKxHD9FMBeOokK?=
 =?us-ascii?Q?FiOd2M5CXZ71iBEEj5oSsOOaUqp2d/QLwU4pNfmn4JGstBVhxNwr+VAsNn0G?=
 =?us-ascii?Q?bNRlvCd3/kKB3ONvSXfbMT1e6m8tr3k9yxbWBS5teoqvDIok9OHJ4J2b0jnu?=
 =?us-ascii?Q?AsQEXbWMhXhYrpEgxIujpsClM9JrdFdz3Sx4HRJQOWAFXA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?40GlW6PsNPN5eKfa9umW0gtiWnnHFecyfDHQvcMkPDjKAlEKb5CvZeZD4mAu?=
 =?us-ascii?Q?Gnq7kufG/jKPrVPf4cvW1ft2IotchEuk2cVJlR37IB5kPy3VnLFA85WC42Pl?=
 =?us-ascii?Q?N7S/inD8yrbsiU/xhtZdYqcNi/woggs0yY459OveQ8OjMf7Icqxj1KTjyCdG?=
 =?us-ascii?Q?KkbOLEvlNK2diU88SCozNyFboh2MtN1m2sBZLLfY+ufTZ0TBcHaF8zfNd1X/?=
 =?us-ascii?Q?UGyVmx55SelSKEPGq46MWnbGIZgNDiXQG+HgXaKzwmgyquMPPDO4pEuM5lTn?=
 =?us-ascii?Q?EEMh5YRdDr68Jt/vKm4WL1W9cMeCX5cgQVej8Oancngonytu165LBOvX41GJ?=
 =?us-ascii?Q?MQDStXpdQy+hE1jP+LCO0w29db08cNZSNZNWZDIF2DW0czLhGB3Una8JTqer?=
 =?us-ascii?Q?oKM9W1DWupjwUxsE2FSmv4Ma/uTZ/ZKoh3PySmzUzCCGhkExVQ4B60R+UshQ?=
 =?us-ascii?Q?VciTKlK4QRjsb/BJGq429rOwbl6rvzRuIxm/E2H7PGeq8ca5I+a5Q+/8hAQr?=
 =?us-ascii?Q?rB7Bs8W78VigJcoqqkKjDEkrHEElcO429KbeQcWHMZS2VorDHYZKEqXTqJrj?=
 =?us-ascii?Q?+5PZyoza3fYLy/Q71nMgsiRlXtPREVtzWySwINojOV5cXuAV/jGt1bYVu2V6?=
 =?us-ascii?Q?miEuFymP+/wUcrliJy16spWXol+minhbrtaNEzovLRkpEKr8ccoebhosADkX?=
 =?us-ascii?Q?D8JbvVjBwY1aA81DnQyQsi3/6SdXvsnIGGkWFlYn3qLhGpBLvkOoUtzoJ962?=
 =?us-ascii?Q?nVVszV6P+ffOH+0OmqruLrqjK7bSG3hjokPD0pRDTM4B1XcDYyWq9MqvzCGp?=
 =?us-ascii?Q?ZxjvECPn/cZ4suCc9XX90+82Wqo/kqwqeDKlGx7pFdPOaoBHd8frEvVy36za?=
 =?us-ascii?Q?3qw+5usnSp6osDrZ0fHkkz+O5p43G2pSjtHrA34YDLO8W81/xyIhqKLSj3IF?=
 =?us-ascii?Q?UP6wghK4X+hOCl/JSgWBQvqWnYkEKa7yGYAihSs2vnO8T7jY3s02HDbVIrVL?=
 =?us-ascii?Q?T4neSZnVX2rVFvfPf217i+OJtKkeiOPUZDYPwp9RlJqWu1QNg9qhPP1OsYdU?=
 =?us-ascii?Q?kpmNakbKXPH29AdIIROHK6TBgHfKu34boitwGi5bMBX1Y8G3M9QIuljmkLbG?=
 =?us-ascii?Q?jIvQh1ZDQNG96rCtQc17uebdTeO31tjtiL9WoXpGhDQJFTR8gagJk4x6re6/?=
 =?us-ascii?Q?7t0LbqgeeTeNPh1tq13HT80lRlf/vr5A7OOncDu98lo1tePjNmunOpxu0v0v?=
 =?us-ascii?Q?vDAkRc821zUIfqRplLdYWmkmUTttGVQmXyDe9E1Ef+AMhRdPyBBUxOKG1BYd?=
 =?us-ascii?Q?pedc5xaBkAJrimoUhmmefsCEAgii1AQ0A5Z7BRdJOSj1lAyD7nEdi68nmVq7?=
 =?us-ascii?Q?yqw4cs4L70lz2CVsBC8Non3neHIUHEy47cOUOMCnWPDc86wIhA7luvMkh/Vx?=
 =?us-ascii?Q?3GmIyPYvcV622hEVzNw2UOcAeOq8mrEkZxzU8+eMJ5IOg77sg078YL4qb5aO?=
 =?us-ascii?Q?8lAug9rw5WzaD7tDOU2hkb3q/5l3cpZL4pyymKUNEHw8zpQ5tD3mRNz6Ar8P?=
 =?us-ascii?Q?y6RCSvQsfTpWucwiFRU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7699.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60ed0d9-09d5-4499-73a4-08dcded717e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 09:30:57.9352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAk9ro+1UVuUdbkx4gpaAj0KBRleRoAsssOnR7RdQYkT55MWTwuf9HqGbQjsQ3AHSlVTnISHbvVl9drXOzBZew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430

Hello Conor,


> > > Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks &
> > > clock-names properties
> > >
> > > On Mon, Sep 23, 2024 at 06:02:42PM +0530, Amit Kumar Mahapatra wrote:
> > > > Include the 'clocks' and 'clock-names' properties in the AXI
> > > > Quad-SPI bindings. When the AXI4-Lite interface is enabled, the
> > > > core operates in legacy mode, maintaining backward compatibility
> > > > with version 1.00, and uses 's_axi_aclk' and 'ext_spi_clk'. For
> > > > the AXI interface, it uses 's_axi4_aclk' and 'ext_spi_clk'.
> > > >
> > > > Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> > > > ---
> > > > BRANCH: for-next
> > > > ---
> > > >  .../devicetree/bindings/spi/spi-xilinx.yaml   | 29 +++++++++++++++=
++++
> > > >  1 file changed, 29 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > > > b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > > > index 4beb3af0416d..9dfec195ecd4 100644
> > > > --- a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > > > +++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > > > @@ -12,6 +12,25 @@ maintainers:
> > > >  allOf:
> > > >    - $ref: spi-controller.yaml#
> > >
> > > Please move the allOf block down to the end of the binding, after
> > > the property definitions.
> >
> > Sure, I'll take care of it in the next series
> > >
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: xlnx,axi-quad-spi-1.00.a
> > > > +    then:
> > > > +      properties:
> > > > +        clock-names:
> > > > +          items:
> > > > +            - const: s_axi_aclk
> > > > +            - const: ext_spi_clk
> > >
> > > These are all clocks, there should be no need to have "clk" in the na=
mes.
> >
> > These are the names exported by the IP and used by the DTG.
>=20
> So? This is a binding, not a verilog file.

Axi Quad SPI is an FPGA-based IP, and the clock names are derived from the=
=20
IP signal names as specified in the IP documentation [1].=20
We chose these names to ensure alignment with the I/O signal names listed=20
in Table 2-2 on page 19 of [1].

[1] chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://www.amd.com=
/content/dam/xilinx/support/documents/ip_documentation/axi_quad_spi/v3_2/pg=
153-axi-quad-spi.pdf

>=20
> > > > +
> > > > +    else:
> > > > +      properties:
> > > > +        clock-names:
> > > > +          items:
> > > > +            - const: s_axi4_aclk
> > > > +            - const: ext_spi_clk
> > > > +
> > > >  properties:
> > > >    compatible:
> > > >      enum:
> > > > @@ -25,6 +44,12 @@ properties:
> > > >    interrupts:
> > > >      maxItems: 1
> > > >
> > > > +  clocks:
> > > > +    maxItems: 2
> > > > +
> > > > +  clock-names:
> > > > +    maxItems: 2
> > > > +
> > > >    xlnx,num-ss-bits:
> > > >      description: Number of chip selects used.
> > > >      minimum: 1
> > > > @@ -39,6 +64,8 @@ required:
> > > >    - compatible
> > > >    - reg
> > > >    - interrupts
> > > > +  - clocks
> > > > +  - clock-names
> > >
> > > New required properties are an ABI break, where is the driver patch
> > > that makes use of these clocks?
> >
> > Alright, I will remove these from the required properties to avoid
> > breaking the ABI. We're working on the driver patch and will send it
> > once it's ready.
>=20
> What changed to make the clocks needed now? It's possible that making the=
m
> required is the correct thing to do, so breaking the ABI would be justifi=
ed (provided
> the driver can still handle there being no clocks).

Axi Quad SPI is an FPGA-based IP that was previously tested on MicroBlaze=20
soft-core systems, where the driver didn't need to enable the clock, as it=
=20
would already be enabled before the PL is loaded. However, when used=20
with ARM hard-core SoCs, the driver must explicitly enable the clocks,=20
making it necessary to provide the clock information.

Regards,
Amit

