Return-Path: <linux-spi+bounces-8885-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0523AED82F
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 11:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06A23A4077
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 09:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC2024166A;
	Mon, 30 Jun 2025 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="aYo9bsq0"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0468923E33D;
	Mon, 30 Jun 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274525; cv=fail; b=tK+cOnr9tPxl1njtNZVFX5lo3OiWqqnjR3KVnWAmYHAD+RqFRBKXjQMq7SoXz1ctEtx+Vgyck4P0fuOX7+rILKS5Wm4amzMfT+S9YHm2S7I1X8CCYtWleZlPmWzWLl07DUZxbEIYeSzj6cLaditWiKx73U2OWrPND/C9C+k+csA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274525; c=relaxed/simple;
	bh=xvJIx+c+Jqsn2II/8xw4mUAsx6HurZsaD3ggdyqNCtA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gLZsGQNpK6Q4WSFUXptUdCemRz7PjCCvm10KPGbNjxGd+jXOCGz+Z7uxEEw627M1uR7HIgl2n0txqWm2NAnIOf8BpiohSkvHAy4zVsy5awfL+OgFmqm76RfAdaQUJUviXQRE+G161JuWuiu0KEAbysrdrB8YZctc32Dun91Vkvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=aYo9bsq0; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfLG6uYCq53nSBZboY3vMtxzH5gWwBmZENmimujeY9nBqOi9peJIMU0aF8lE9gm1d+SVr3ykr31t42xxlVB4fnsUceBtMGvgA/OLNMNSkzdKRwYOCIRwvfuB3TeQ8wCfSnWCSOCZ/UvgISHoHzjdxt54YpUai0zTPeQ92cbu0/5Dp0KX1vbCMi318RrCzP00zDALy8e5dc12irmKRJzmHB50JaKovQq5vRsoihWm9syox8ih9+szTO6cPUJm0Jni5W35bc/cWzwnSJhII+8O0C1vXTVL/XB4KK5W8cyvV7K0F/3ifutiFkiqvsylMSAlFLRrEUDaR0h/Kr01uLRKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14KHa8usUV9Tq6OYcsaMAj8pt7dE7SCgT15bhGnmLcw=;
 b=X6qQpA5ncFL9Azh4rF7DUDFfR0PfxvlGghXws0D6z0eDDF33jlbbdwdRXttaZrzAiMzN8NPeWidbwT3Z1mADB0aq/63Sqi9j149jKpyKAa0o0Z19p2twVmi3NWb1/VS40kGlj9VFnDZW7GT5uEWpXTMVF96nUG79xA0VmXrguA1QNTHftCn0l3cpHmHwIlq5+X10fwRlvGAlYG5FNpAH71Rd1wIpOsWd8fYNIsfViuL9X/ezKbidtG2ILYNsRScE4UaC/8knsZeShNuOmPcfHwXn1tH846SIq9qQ8lNnsoc8d0ygxxVYTM05PuYI0HQLkWOOaJTX/Ak3JOmY6/3z7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14KHa8usUV9Tq6OYcsaMAj8pt7dE7SCgT15bhGnmLcw=;
 b=aYo9bsq0m/lHQcMbzrKNz2hbBUzEkLrsrUpp/oljwFUmrxV8/p9nS33eXDdD0ZZiQnveo+3xNRA4L0Wxj48kpMUy7Y4xVqW0AupcQPpOtYedNJsnu4yHfOCGRtQJtOpQWJpwF7YgIGSp8kWtg/IzNs/SE17E7yeLoTjg2vc6QsuFyg/+eGxBLlIecpq4SGiEnbT+nJmFtXAbPJubXDfuDsWWtkJKWHVwV8pTNCBovsuv1wodF8cnIPOixVfWIPMk1f04iZClf4uO4UfsILzd6vh956f3UJkhmS6dwoYFVKJadKfGUQZ3bpZDr6bpumLg1igZwC+0s8meK5VCMBxH2w==
Received: from DM6PR03MB5017.namprd03.prod.outlook.com (2603:10b6:5:1ee::21)
 by SJ0PR03MB5391.namprd03.prod.outlook.com (2603:10b6:a03:287::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 09:08:40 +0000
Received: from DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168]) by DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 09:08:38 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Mark Brown <broonie@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
CC: "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "Gerlach, Matthew"
	<matthew.gerlach@altera.com>
Subject: RE: [PATCH v3 1/1] spi: spi-cadence-quadspi: Fix pm runtime unbalance
Thread-Topic: [PATCH v3 1/1] spi: spi-cadence-quadspi: Fix pm runtime
 unbalance
Thread-Index: AQHb3BhYLZgMH9u7KkOzqYRdh3pLDrQWgkyAgAAAbQCAAFsSgIAEod9Q
Date: Mon, 30 Jun 2025 09:08:38 +0000
Message-ID:
 <DM6PR03MB50177D7B29E3BF39722B07A6C646A@DM6PR03MB5017.namprd03.prod.outlook.com>
References: <cover.1749601877.git.khairul.anuar.romli@altera.com>
 <4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com>
 <ab51dfce-a7d1-4eb3-b469-af35529dfbbb@sabinyo.mountain>
 <62b9964d-0f2c-4d26-9b35-bb7af3aa5c4f@suswa.mountain>
 <aF5s4f8TOpvDJFyB@finisterre.sirena.org.uk>
In-Reply-To: <aF5s4f8TOpvDJFyB@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR03MB5017:EE_|SJ0PR03MB5391:EE_
x-ms-office365-filtering-correlation-id: 8abc24e8-7d04-4855-1252-08ddb7b5b3a5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vP4FZ+NXXHXhUvWDdKf1cROnbzUn7UlmAdcpEC/+7k/qgfot0MX5mrhrwO9V?=
 =?us-ascii?Q?XyNezvg0iO/sxSo16UfSXcytHhHoSI1TJ/1uzZnVyPN/2MKpM0Wpw/ESdUpo?=
 =?us-ascii?Q?+0gE76yLkjIGVR8kVdx4VPoK/ksLB6WUbbwPgPRO9yKf8LpDeKB1P+tVDBqg?=
 =?us-ascii?Q?Qxfpv0qDSzKmW8SC4Sdmf7dRy9nm+AhN+NFiLaYaHO/hpb7iTgoFuqw5bDTN?=
 =?us-ascii?Q?cVKNiGJTmBLkKHNbqZfO9AQpBHcmso6WZPO5BPb4qjop4XuVN5n2jEkmlfW3?=
 =?us-ascii?Q?sPr8/4O0BsPU38o5mETOw9UeMOJWio/op6IjtUBMB7M4L5dkSxGiv6bZS9uA?=
 =?us-ascii?Q?jFPgsawOKDhWqdD7IhS12lg0PkZTbclBPTKDZQJPe/N7nwK0KL8Khf0AVZor?=
 =?us-ascii?Q?JeGlAoEclU+/Avufcy0dHB+PNHovlkp6revCPp9tCyZvDL8VDHLQdiBDkoK5?=
 =?us-ascii?Q?jSIKngW9oHQEGdJw8YfMLSEUJNIx+TcFeP0W2rWFXf8j9DUsHvSMMi5Tsl3I?=
 =?us-ascii?Q?cRez9sc2m6Ui3ify1lNCWQtxOMcI2Lv7p8sNg8v+MwdvMNTynuS2ltl2BFHO?=
 =?us-ascii?Q?sCitdryboej7vzstV/npJL2yk4Vu74hlxuuW7dgXFUz24jGjOCgXDb88Lyqv?=
 =?us-ascii?Q?a9s2qWki9jrpqiW3o9eTzazGfrhsp+1Y7sLzegKNBFlRKm7RdogbaJLsyobL?=
 =?us-ascii?Q?SJ22oPXGsCys6IsU6Er3qVUCTRkJD4NUixqBArSpR/Beg06CHDLFe7rt68M5?=
 =?us-ascii?Q?UMdDU72SACshJtnphmguMN8Ta3r0x4lSTi8h+PbEX9DcQ5RgAk9P0CWjC8Og?=
 =?us-ascii?Q?Wq5rpclQ4Np/8O9dbbccDRO1+RGCVBD8EgGBLn3SSqQ1hrdowOwiS64Sz9WE?=
 =?us-ascii?Q?5oM1cfqYQxtOLGJ56QH+yOW2YjD1psl+VYq0TY7dxo+EALhRdUQl3Y8mPh/W?=
 =?us-ascii?Q?7HnmnwTAepKRZCn3eR+Ps8+47xocCBo22QD9t0JyS75AQOK9WXuJoi9TWS5n?=
 =?us-ascii?Q?JcVoauB5EFsb0Vvt1eN9HJpka6RISXPmniXYByRoqC9ENnmwHTQHATQBu62j?=
 =?us-ascii?Q?pHKSURo4Sl9X5siN8+y+pxJa+sHPXL2/V9usxgzSlUci5K6BYvAYPPV+Zs+I?=
 =?us-ascii?Q?uQh+hSf3d+s5NuUC0XZZAiUv9ibsGJPz82k20T8BhY5XexCP5mEGPF8Tb8lP?=
 =?us-ascii?Q?wRz0RoY5ZVNySQhnBvchHqI4ik5Zk/rR2DUV0sonJu+d3BR0Di04uhGiSJFG?=
 =?us-ascii?Q?6uLcRtVRknXZfK6F2kd3pz++aewh7+oHwd5c1Fw+t9C/O7YEy0HVD+o22iRM?=
 =?us-ascii?Q?C07VIR7T+uZkHGxnXQ0RC6VlWBG5Y6ACcglZHoBmd6pKUBX3EDPtfQjQT1oO?=
 =?us-ascii?Q?E9adi6FS+VEGVrDgFbq5UTlLBuOMpykWw880AfRxkeOomOphHnn7rVpf+P4Y?=
 =?us-ascii?Q?zXVrPN/nQuSI1jsO5JL6MVYdSNQSSQnKM/fR6rNx6FRBWP+kqRYOdA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5017.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9P16nyeUdU/bGQ5JJg4EIiilnG22tq+cmXJG11kJ4X2VZqn1PywcjMJdAqOU?=
 =?us-ascii?Q?cCth8k1dLlqX1PlpH64QqlCfXVqatqEJx6qIHA0ow94W3tdNlUB5Jrx2JeT9?=
 =?us-ascii?Q?Axrmx6cVefVQcusBIEKK2jDO9DiAhjmLV9uelSG4eIWkC/GiR8Gb5cmfVBJn?=
 =?us-ascii?Q?TSf7CZtkRN4k1ld4eAKhRF90kmY8BzTwCSG9He8iyHI8fYbIjyo0K8ItMuLW?=
 =?us-ascii?Q?2mY50pdr10gp/CPMug+rOmHzefnqot+b43wULh5C516g1DX+shaeejE6s7t9?=
 =?us-ascii?Q?im8A6r1tw8FBZv+WZruX69nq1ph51YiZinLK4Pdd/hNwXm38+BNUpJ0C8V44?=
 =?us-ascii?Q?o+8jNIMiaQ44zTjNUt0MXINAmkzAk4IRdL8dQsb9Kh2P6SpyXELDbdIM7o+6?=
 =?us-ascii?Q?7grr/yfG6HnSTGIXOHnFBUG+/p5Z/GK6a1HUiWQarUvU2ZoL3v/C46xe7Sx+?=
 =?us-ascii?Q?R+6sp8WRa+oGmIvcnznlNUFFaTINcou3cyZ10gMdJQ9GFLeC+NzpafiKz+S6?=
 =?us-ascii?Q?p3Zfk//959jsa88FUmT0yM4FyORiDW0pGwIa61KvZwHQHWmxvKLewRrmPOMg?=
 =?us-ascii?Q?w8aTe960P3iAw57vqPEuITAiCc8ZxUhxnP5x24L+KNLAnSFyoLDYAes9y+GZ?=
 =?us-ascii?Q?sQZRI9QAjFr8pXa7FJ2D3MPLPKrT4QQbBeOIgxZR/7xRUiodQJaVRSUYRXRE?=
 =?us-ascii?Q?p/q+noa/Spra2eRO5QxFGN6WYFa7c3R9nk8ujcYvTj7IFk/VSJF0PE+aEt0A?=
 =?us-ascii?Q?yGdgIQJKQiU/LaCZZUmMTmNxvivrnRIVbHB5ZSOYVh2Mo0wm15TlugbHzOAq?=
 =?us-ascii?Q?A1jhgojaTCgGzdqn6OFmOBtUEoQfpeT/AMdzRvmL6HUjGdc3DQhXOTiLBgza?=
 =?us-ascii?Q?tgJROpQ2XgL46U3ZG5uec9iQEdI1ZfJ1lc0du6df8RkEoYD0yVcksZ00g+GX?=
 =?us-ascii?Q?xJz7I/ebve2imPRWY2dWrRxlpRtVMkSIUnfrGaN63cLskVRSnuY1cN2seYXi?=
 =?us-ascii?Q?f3pRBCK4wSQf0XYPMMVdCynj+PbVZDyagnLTjyhtgfwYBXflC/6UeDLYYRsG?=
 =?us-ascii?Q?xZzJ2e1VS9cbVEp0UUYA1fU8C2lAL/qowyjd6cqfzNI9sEkJw7D8v0YzWBJ1?=
 =?us-ascii?Q?qYCm/lcJoMbYYNOlpLE5aqI0fJhC4Z66PPmJ1E+K59NE+Y4Fc5QLPNzH8EnY?=
 =?us-ascii?Q?s+b86N3a0XE+0S8UL4m8WaXQzbSLNBNgbLNGZp7tYZs2GcA6m4fuwMuQAau4?=
 =?us-ascii?Q?c+dyofLbEPmmMg9vtAnqA2csbqi+IDCltWw4W4WyfKgXrxhdREQxjhADWjYs?=
 =?us-ascii?Q?Xg+7t2Fyv6t1ShpXqtkzkYS0JQnAt8bzpf02R5wqSRre9TVG3yM4ommjeqWn?=
 =?us-ascii?Q?2uAwbJcaiR8Edjwp3WWp40i8FYWUrpH9UBvtEZfvZX/suYZif9niLGA+5qP5?=
 =?us-ascii?Q?6jRU+A+VwwUn1RhSA8Ke1lBsNkUxr8qQFGZaTxGAHe4eHwetQTJVSdBHvvlv?=
 =?us-ascii?Q?CAqICgSA/yA/RewrqIk7A9mSHCqvtroRevHZgIvIWYCX9DQW8Jmz264IKSkQ?=
 =?us-ascii?Q?jGiKmXP5z/47+Wg7NuhkLiYUG4MlJIQGBbfdzrcy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5017.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abc24e8-7d04-4855-1252-08ddb7b5b3a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 09:08:38.6816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhyXS7WDHS7nds1BqDHIZzYTEqhFCPhYzQlCrDeubKIMlbUEsWkzs+gkY6JX9JBwHekJMt1W4e/Y81HUViEDJ5156ZYjYPRdxL+0CE2yM/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5391

> To: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Romli, Khairul Anuar <khairul.anuar.romli@altera.com>; open list:SPI
> SUBSYSTEM <linux-spi@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>; Gerlach, Matthew <matthew.gerlach@altera.com>;
> Romli, Khairul Anuar <khairul.anuar.romli@altera.com>
> Subject: Re: [PATCH v3 1/1] spi: spi-cadence-quadspi: Fix pm runtime
> unbalance
>=20
> On Fri, Jun 27, 2025 at 07:39:24AM +0300, Dan Carpenter wrote:
> > On Thu, Jun 26, 2025 at 11:37:53PM -0500, Dan Carpenter wrote:
>=20
> > > In other words, if we failed there was some slightly complicated
> > > cleanup to do.  But now it will do the cleanup and free things on
> > > the success path if we're in cqspi->use_direct_mode.
>=20
> > I suck at email.  What I meant was delete the if block:
>=20
> > -	if (cqspi->rx_chan) {
> > -		dma_release_channel(cqspi->rx_chan);
> > -		goto probe_setup_failed;
> > -	}
> > -
>=20
> Can you submit a fix for this please?  The patch is already applied and i=
n Linus'
> tree.

I'll submit the fix for this.

