Return-Path: <linux-spi+bounces-10610-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEA7BD8B52
	for <lists+linux-spi@lfdr.de>; Tue, 14 Oct 2025 12:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D123B0242
	for <lists+linux-spi@lfdr.de>; Tue, 14 Oct 2025 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15B72459CF;
	Tue, 14 Oct 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DlIaN3lm"
X-Original-To: linux-spi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920D2F56;
	Tue, 14 Oct 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436937; cv=fail; b=RIe1NDb3vrZzMuS2zrucGfnJmlXVxepgD0k5M1BjpdB0eS/FzadAWg42fMdrkFAsmeQROH4mHYK3B6weKkIKyYnKdsnWEo/rZLQ+wcRQOSnsClO/f/WIRW7xj7OcpH6xraAFAMUojgTnv62E99iElWx5FRbVp1mzo6tsvGtRbl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436937; c=relaxed/simple;
	bh=V9FMSf5sdSxrQJYNLc4FKBwaETbs8xZWEn1VqS+Cs00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r+U0Nngd45QJLw5Q0ZeqmWGTfcWFeXscj+9Mm60hs2ENkGDHnn2gSlINvrdjryN3fuhoXxYZ52j7RuJweago3tCmH+LXsxhl2LMatbFm1tWt5Dz0K8OrvBRCL+3ZswugWka+WFEzOz8Pdad/5wIHr/D4DvCKDL/c4sMKKdCW+Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DlIaN3lm; arc=fail smtp.client-ip=52.101.61.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kInsgDlaFDiZVYoSGR+4ba1oBUoyKQt7ETRsjEZtW874tlgJs1+tVyiF7MiXqouHqeu6dLZQlQQrsWI62chW8jJctFlZvDggvUFsS0Np39vdHCEXE9Gm9zYAnqr7vMQIei/MHobgr0NRFjZ1KTP5W9QvTCA05IxbhSy3kgkGXQrKgzI5KkIoGa+qqfESifqULNKeQHYhakjHWC8Vg6O2KP0ttarZbOzO8J19W3c4UxJh6TC1j3IoRu0colG0C2OKxe8pbMASFQ1GH5z8MFbpXR3mJLztRdbR6RMs7s43zIBVKC50E1p2xwXB5bLfCbL7g01aQ5UDCNB9MZyWYM6wdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaZM3ZCv2k3rT2U28N3om/a3XnvZlvfWLffh5EMsh4g=;
 b=M5ej2qe4VIQIBnWL4V0bNrsjK7awFj1A5iCDvT2T2F5mthghlHo6Uxayt4RbtLgvECQ0hA6kCyav7aT+Xtfz9LEo2MQgCWzw8u8SCu5KgdpaTn80GM6g/JsTZ2ayrikVL26kIf7RjXTZ2p4CJ/Zj06Q4HN8IeapbcPdDDrL9qNDLhbVJYqNg7CKlFU3503t1iMtrrr6ziLWjGb0HR4Rm/l26nY97IsNFdHo5fzCd10ghN2sl8aZ2ayAPITyeGS04zvBsld1USvkPpxibIp8KaLY1i1SxD/a9xxawUt+vHy13mlMmstoekSjo5xR7OaMSE0UWBDKuKIrz00tTHMBeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaZM3ZCv2k3rT2U28N3om/a3XnvZlvfWLffh5EMsh4g=;
 b=DlIaN3lmwtkFvJBvi1gDHmua8Jlt1Yr4mhagYrw3Cmkok/fYJSP6YZZjl+c5svC70jdyN1WOjvaBWw1VchoBWDMicplQRjl+ywbZ5TMSo7JM5emSWbB9o5IH88F8rnonnF/zOLj2visCHn4Gn25cWV4PBESU0MYX/r9nYVYL4n0nLvKqfbPLaARqz8VxaFQ5LsPfxovcCRnojfrl8pb7rcm1ZjspqJCA09M/9KUJcyFSqo/U32OeNLds6aOzMEl8UYNPl7sFtjikWQJGIKMsdaR7Iva4+ksYRP9xE9vcWL5prHSKWWGIP9U6UyDvrNRIEwUnhCq6OkU42hIBTczIog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 10:15:32 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:15:32 +0000
Date: Tue, 14 Oct 2025 12:15:25 +0200
From: Thierry Reding <treding@nvidia.com>
To: Vishwaroop A <va@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, smangipudi@nvidia.com, 
	kyarlagadda@nvidia.com, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] spi: tegra210-quad: Fix timeout handling
Message-ID: <dhbvszhpgmgxqdatbbou3z2mj5bu7vnbr7ko4ufunlycpudsml@6xnz57kowygw>
X-NVConfidentiality: public
References: <20251010152001.2399799-1-va@nvidia.com>
 <20251010152001.2399799-2-va@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b22zu7prl4mp6eej"
Content-Disposition: inline
In-Reply-To: <20251010152001.2399799-2-va@nvidia.com>
X-ClientProxiedBy: FR4P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::7) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcb6f05-ed2a-42a4-a8f6-08de0b0a9b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9IGOHK/BVPddTO9OGX/bKUtFGp5cksp0m9lZPC6CzHHL1+/GU7inwth9iHIi?=
 =?us-ascii?Q?n3eudwr6i3wqKf0kiX9FRNcXd/WXpKSE8EJ2VKWLvpb3TIlPQPcpLrKoSjZI?=
 =?us-ascii?Q?lHFoEvHJov0ger/9fEnVfVZXgqDCx+1l4t7nPC7k2MK7ht4Tl/IgsC5SfUsA?=
 =?us-ascii?Q?ndpkkKTK+NN+0KsLdMR46e9vWRRVAuZRevs7QUbmJA343aPe2VYo7kKWNdcn?=
 =?us-ascii?Q?VwCt4skGAwkNXjxic1A1O6oyy5R5wSGeAfkg+rJTQa88te1gsyMKzqpoVM1i?=
 =?us-ascii?Q?9tb6MmjX7vrRwxc6tSE2WfaRpMjUQv6yF1lS61SHxCOHCwqUNg5iUuHz+Q49?=
 =?us-ascii?Q?gdyYVU1ZS6kyq7QQnq8A57EleCz4c2JVL7F1G8PDjMUk5LKWpzBuzn5jNqZ3?=
 =?us-ascii?Q?j5bt3j/82txmyHAxh9Su6Cx058jFXxPBkjwEl2gV3JeXQPlp9AJhPCm9oRZk?=
 =?us-ascii?Q?Sjsh7WZAAmeD13kkPkBwfMPoNngTxMKdOpO7QmhYVuro15rOqFbI+Cdkpq1A?=
 =?us-ascii?Q?Wjq6Geb+Skln6ABUSLTyIRFSnVZHt+efo3DI5KnENOcBwWSuPAeSGHlwGXGG?=
 =?us-ascii?Q?tUyP+VyAdtOlRGgw1m+ALunuzZwKcp/urYR5aoST8nluHoi2wQqQtpAv2nr8?=
 =?us-ascii?Q?HS5bOajiQovvH3A4keJ7nLGpMdesDG1rZDF63mLk2C2XoBtXktWIjiyl/JlA?=
 =?us-ascii?Q?N9atQx8mrXTRX8wOAnloAXvprkZiCoyle7RZLijh6Xgr5EYP+H1RnmD74/41?=
 =?us-ascii?Q?2OKfEEeWwq4+1eTt5frBI3HBg2sKsyhRGYZV6sZhQyRUSxF1NPY0M0QkCQU8?=
 =?us-ascii?Q?pL+PiqdknWktdTqn2XTb2TdT6HxGi55Jx8NytDn1m7twaww8i8YGjfD/HEmk?=
 =?us-ascii?Q?PJ9/RupH0RLRXUlS5PadhyCDi7OXGDL/Xq4oJpHoYtImRwwHVPSFBJcknAAL?=
 =?us-ascii?Q?FrABQx6m9pBvw+kUo2yV/4l35o2y1LHQ8/eNWQEc0cZqPYIQKnty/8wDMt0C?=
 =?us-ascii?Q?1hQ4ByrE6dsR5VnYazDXr0Qbzn7z1gadL8UVkgg8saq2LhpwqX4QDB+js+qS?=
 =?us-ascii?Q?yKaMt9pb/jfL4qRGDF8paykjta12/yzi/yWYvWYZmxbmyv+Ahh2ligmfc6p1?=
 =?us-ascii?Q?ywpNuGr4i+VpiQEdRayXIwRzyFl6dZdxKaRLDwjdXizB/fmVL92ScfTNj0jD?=
 =?us-ascii?Q?96sTEE8AO7TZ2BFeerIu0LBZDt9UW4oOLsUIQJKX9fiZ4Z6/q/vLWVdbUSAR?=
 =?us-ascii?Q?KrctO/Kb70F9+uyg3nkng0hyYjtZUWpoFgjCfjPVosKgyC66t9qSHV0pUKPc?=
 =?us-ascii?Q?bj7fL7tAMZAoDHfgmAqTUnjEtcyl8tBXvtPo5dO7eekppmc0FLndO4QXhuxT?=
 =?us-ascii?Q?g3742YkVbK+KPl/Etftfs+csYQKDFP0fkz4suNdpRGTu32/KQHVy+netj8zy?=
 =?us-ascii?Q?jQYUJ369vr1yFaGWzag+Xn2A485hofEx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8317.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OqUDptGZNhrR362vDflcM/NJpbUx8ZMOzlFX1pUPVj1CxnpDaMB/M0/NBhBq?=
 =?us-ascii?Q?SRnsu29CKjmdpnx8rUYBryyCYLEeaZaEPjA41Q9aiFJgT6mws+YUOVXoUrvT?=
 =?us-ascii?Q?h8F7NcpqnGSq58z7cdmBgnbRs2i9pwHP1AsToma6JRORpAZxLVSbFKn+Exls?=
 =?us-ascii?Q?KhIW1dbyK6FVoZqgoYJy+ehA+CeigVGiDvitWoFm3mA2MHrgK505Rv+96ytY?=
 =?us-ascii?Q?0DhzYEWswUq2p4uLZH6Lvv499hYpisSrTCqaC9nVPc15lUasmIoK1nZMwiuE?=
 =?us-ascii?Q?VwQxdOfD6m9fcY2YCsoY7Ayx1CJOC6ziC1NoEI8TO/zmVFAvDf57meyvp04L?=
 =?us-ascii?Q?MpTxbGgFXUAQmGJoBlWrJciBbHWxmpwt0MVipW4Jmx1qYPhkHObCanFswhBn?=
 =?us-ascii?Q?d7stYH5b4M2b8VPxwz14D5gG2XBxY5HKFrK+W6R0ITVO1hbu8hIKFJB4frFP?=
 =?us-ascii?Q?ID7mNKROoeO7d85Fy/M6dlrmnAxPo9W+IM/Kp7PNd76IJUu4krC2hEhBa8D/?=
 =?us-ascii?Q?jsGnQFFne3JTDr20QZUf87ZksUF5A5QmG3MaYU1aVcEPaxwrohoQjvdq5cCO?=
 =?us-ascii?Q?rbyzUeKX8khtDLq/YPuW0CHAZCw474v5cSLBkBSngoA+YhorK2lgk/0uk//A?=
 =?us-ascii?Q?sBT4yN+1Tb40LbFY1b8CpE9Nl0/GxoDb8DeOL02w+4b0QXHUFJvWOVVZqrP2?=
 =?us-ascii?Q?+6DpiAV9ZVlzvw47EWZIikmGYh60j3Bd4Ef3G4a1v/OrWm4mh2l9Gpdn9Bt4?=
 =?us-ascii?Q?uoNkRNjPgfKrfSNOUadC1CIZjKGEfs9fTzvt4VROgSe0FcFtKHs6loSfNTUg?=
 =?us-ascii?Q?f7f6IxcOBQP7e2zqESsGhrzcFgS6VZGt2/W2Y9D0C8QKpxUwBm/FVAS2VLme?=
 =?us-ascii?Q?4DL+RSVXrVfXVJT3xvX434diiJLRpKD1NlEQ1ejmx6hvTiplJ3gnd78gVqj+?=
 =?us-ascii?Q?FlBp3STyLEq4bYg3q5wJ/rl6jVaepHtSrLrrqxYqE2goxLbGhk/WMx+WsB5Y?=
 =?us-ascii?Q?lK4dn3vPPV1O+YJYACG5/bInFs35XpK6LPjz5s/ma66HccN0eyOPIw9z1LHL?=
 =?us-ascii?Q?/0Z7FHORsh2j+yXQf9LzU0gaiK4dGmHL5563l30ieG7EMlGhSxCqBgEYskul?=
 =?us-ascii?Q?FK/kfChN2s6FFKtyWBgWzLFPQMLeHf/XMCm1TlZf7jQ8T0MrZXGebYZxkgUq?=
 =?us-ascii?Q?jhQJs37BfdvRkpJ6JmnCSrqrgZvP/iKwjWoA59Q6W356zsQT4AYtxd2T7iJp?=
 =?us-ascii?Q?Yz3xWzr1TCbOG6AiUf50UDllel4BEw5JeErBzwg/68ua15oWK4Io6QSmVpwr?=
 =?us-ascii?Q?llfpjzc3sxbaCb1eLdcSX9fqEj5lDvDOc34yNYHNRyObs951ZQ+ftb0A4u50?=
 =?us-ascii?Q?WyTESKG8wyf4E/quYQ/9a2e6NXyqBEra3PBIdo/UNJ8jx/QFs7538ukPjGmm?=
 =?us-ascii?Q?mubbpXNLytKYyPQMWt7dnpKYunr9hLrvaooO3s8hLcfJNmJNNcqTZwR9MALS?=
 =?us-ascii?Q?3dbKioQ4EOIl28koq6fONJJjinvorunC6jYY4fGtWGKRoWYdaDAigGsFQwNy?=
 =?us-ascii?Q?JsJPTNZA1yOdrE4wIVhheAg+hRyj5BFD8kBDnij+7Vhc6fAzEiSaAfbCOQKM?=
 =?us-ascii?Q?me/r9TT9yVhsNsVVHPJyfwfCnR4c7NR6fvfQ4gmf6e94?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcb6f05-ed2a-42a4-a8f6-08de0b0a9b48
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:15:31.9228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwBlqDJXlQsCeZzQqjfHib6JBoRymFICnhbtYrl6ems+LNj1UX1GqDr5ZGE2i1BRLsTJkPhzOTgFtledQKYddQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753

--b22zu7prl4mp6eej
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/2] spi: tegra210-quad: Fix timeout handling
MIME-Version: 1.0

On Fri, Oct 10, 2025 at 03:20:00PM +0000, Vishwaroop A wrote:
> When the CPU that the QSPI interrupt handler runs on (typically CPU 0)
> is excessively busy, it can lead to rare cases of the IRQ thread not
> running before the transfer timeout is reached.
>=20
> While handling the timeouts, any pending transfers are cleaned up and
> the message that they correspond to is marked as failed, which leaves
> the curr_xfer field pointing at stale memory.
>=20
> To avoid this, clear curr_xfer to NULL upon timeout and check for this
> condition when the IRQ thread is finally run.
>=20
> While at it, also make sure to clear interrupts on failure so that new
> interrupts can be run.
>=20
> A better, more involved, fix would move the interrupt clearing into a
> hard IRQ handler. Ideally we would also want to signal that the IRQ
> thread no longer needs to be run after the timeout is hit to avoid the
> extra check for a valid transfer.
>=20
> Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI c=
ontroller")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-q=
uad.c
> index 3be7499db21e..c2f880d08109 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -1024,8 +1024,10 @@ static void tegra_qspi_handle_error(struct tegra_q=
spi *tqspi)
>  	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->s=
tatus_reg);
>  	tegra_qspi_dump_regs(tqspi);
>  	tegra_qspi_flush_fifos(tqspi, true);
> -	if (device_reset(tqspi->dev) < 0)
> +	if (device_reset(tqspi->dev) < 0) {
>  		dev_warn_once(tqspi->dev, "device reset failed\n");
> +		tegra_qspi_mask_clear_irq(tqspi);
> +	}
>  }
> =20
>  static void tegra_qspi_transfer_end(struct spi_device *spi)
> @@ -1175,12 +1177,14 @@ static int tegra_qspi_combined_seq_xfer(struct te=
gra_qspi *tqspi,
>  							  QSPI_DMA_CTL);
>  				}
> =20
> -				/* Reset controller if timeout happens */
> -				if (device_reset(tqspi->dev) < 0)
> -					dev_warn_once(tqspi->dev,
> -						      "device reset failed\n");
> -				ret =3D -EIO;
> -				goto exit;
> +			/* Reset controller if timeout happens */
> +			if (device_reset(tqspi->dev) < 0) {
> +				dev_warn_once(tqspi->dev,
> +					      "device reset failed\n");
> +				tegra_qspi_mask_clear_irq(tqspi);
> +			}
> +			ret =3D -EIO;
> +			goto exit;

Vishwaroop,

It looks like somehow this hunk got messed up when you applied the patch
to your tree. The entire block above needs to remain indented like it
was. The only addition was the curly brackets and the call to
tegra_qspi_mask_clear_irq().

Thierry

--b22zu7prl4mp6eej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjuIroACgkQ3SOs138+
s6EzehAAgCLdkFD4kGsefIPxfNIF3HjvYWalHI/ZsITv7BKAWZKrxRldU13jmuOm
gs5h+QAL3HwLKfLAoOrC9RBd2W/z56uYmC6z4Ab7DXUe4CdFFladO+syykoFu1kE
TtZYdnL0yue3019gIMAxfqEYG6sRJsFfvInUlha/O7BXcC8zZbkz2rFkqdPf7Wnr
Ffgr87/8MSaPaf4vaHtWlm+pd5DuBK9XOIGOCehbsEqvrg9zn7nlBSQuPeQawHs8
96TVzxXw1rmeYs+A9T1RDPuL+pNNMIo4v3pFhmMrjXoc1thDGPVDR9OehwnDmseP
Dsh9jUms0YqeQUsNsgIdqjBq+AX9WJRYgezITtpwIh8RILqv2kpTEVAiklmKp2fN
HtaXhJ3s3g4prVVp9T0fvRGhn0D3F+LNHxwMt56oQE+gZy9UYJ4BpzwQbWqph67X
b2aAyOThTdxGR5h/dIIUVN44vIoAHkNRbBQVmcbfbisqx5OIwG8c1qYOxyAKDYHj
MsdG7fVtbOz7VhS8ouGQOQHrOs+/Ugn32vKBTF2Qj3mLJdryYCKBtlPFGfse/0VA
GOTrn1rCuib3KXxHZip0LAtIMfviSRqywgBJc1PHbes4nKRpqVSEkUuV1t+GYGSR
7IIwTI4z1yrUZhBeTohJ+LFGkW2LyHMkgJJ4L76ACMnvJaIA6mA=
=UT84
-----END PGP SIGNATURE-----

--b22zu7prl4mp6eej--

