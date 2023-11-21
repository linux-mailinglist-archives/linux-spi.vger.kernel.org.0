Return-Path: <linux-spi+bounces-3-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C53F7F2672
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 08:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC201C2099D
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 07:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA68730675;
	Tue, 21 Nov 2023 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iSjuWaRs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802AA94;
	Mon, 20 Nov 2023 23:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700552124; x=1701156924; i=markus.elfring@web.de;
	bh=EosEUZ0nK4S+qZnLMvFL/+6ZdrFe0Z8ZAoXFRjOozyU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=iSjuWaRsQcYFrYo58ibZ+AOguuZUd+C3gBgq8nSVni4KmTs97IWvMvT6pQeyjCVW
	 LzU4Q1uQLVJ8Vb8yQBkMT8ibLDk1Tyj36+bGqEHu9zPt/5c4o37tddwUVd7ExCCqb
	 GsjayoqBhJkUA8OBe893xnayDuVkf2j+74gDgCok0YfF8vF/D3SBbjncA9QkywRzt
	 U/uw0X8SF4Zu0Oojchb4oAKgMKMwrfGeW31AZHsLd8/5THvE3/HQmqroE9x8oPPL/
	 GReuM3ManSXMCNZYdgNcUu3L3xA+j/1bonIEO/OGTmBM8KwOg4wOT/ZhHCh5rS5jM
	 30u+5amJBTWPpnhDMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxYbN-1rGery3joX-00xgT9; Tue, 21
 Nov 2023 08:35:23 +0100
Message-ID: <53db2c8f-7b9b-47f7-89ba-d78584c12d7b@web.de>
Date: Tue, 21 Nov 2023 08:34:35 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: spi: cadence-xspi: Drop useless assignment to NULL
To: Amit Dhingra <mechanicalamit@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kernel@pengutronix.de, kernel-janitors@vger.kernel.org
Cc: linux-spi@vger.kernel.org, cocci@inria.fr, Mark Brown
 <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
 <233689d7-9409-406b-9383-49f10cd29336@web.de>
 <CAO=gReGA17gHSr4ftN1Jwrjt5t76oAgaL6+n6X4wD0osJnuq4g@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAO=gReGA17gHSr4ftN1Jwrjt5t76oAgaL6+n6X4wD0osJnuq4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hi5eKYljFyBKSF9GeUsBiWyfByALJmAv3HKwvtad5NVY+MXQ0ZV
 jkx4/iy5jLRQU+ijXzNSSfjItj94nVM5bAjdjMO6gWA237hkMof1r/UCMzh9VzHT6BtXUi7
 s0XZUMiwlWlbq7SJEFqhb7RqZy1X9QdqQEVMNq6aO2u8ZHnJ70qCUGIVYIZ2h8yvV5skeIw
 RjGDt9lZDDzVJGLI8QVnw==
UI-OutboundReport: notjunk:1;M01:P0:wTbQSrQEXqE=;XVsxU66yTz0omK/kA3Zk2un9oxN
 WCuwBpuA1L6gElfpabAQT4/Z0mtrFIGDXUG1iHT+dMLnxtUnPfuuuTdRETtSFchK7QPEle/no
 OLoPBkOTamJiadTrgrSPPdMfBUcDUqDVYoH740AuFnbJR7ehUBoCi++L8ylgUgrEm7D/01Dbs
 eoh4ciWrtcaQ5tHTC2fbh8qCDKGzKZtWer5r6i0UX8fvC7cnW3auJRN8G7ysZsdC2acfpRrHq
 xmPRJu08BEGe07xN+zpFa6ZUO/bIembEBYKTdQqbUQu+2mAQhP83X+jKniRACV/43GlqeYTop
 7x4iL1ttWQ+6M1gJr7TyugjLz9mwUAdkj91zftCVwA15dMMJTnnR2NCsy75f7XKyi/VLAyu6X
 t4Yew75Fq0rH4qJ02oSS0susktGLsQoVhqqxrUhr7kUH/PCU/MuZF9KeoHEOUu67qiMCL896w
 TIMmC8UCbgEyi48+NmNsPQkbm1KHoBpmaCls6vLaU/MrDOQFVBDpUNvNsHqzfqP4C2GCpjuyt
 9Boc9beOvnqTBePplIE360xwRRqCPPAP88jObaOMbD/8t4HyOpKZoXY8oV0WvzAeFt/BmdxtF
 4wLc2WFlOWikIvEGoTGWo0TPy1nPVhIOdYbXuf06iV88WSEyUcgMnUU7S1jCeIVqPkVdJP91x
 fA/zQ5lFjPjhj65+CkhBGTP7NZzhIvZcXo7kWTUCZxK6Wa/5N3MJqWoJNMrD3qvgPdpiaKeC0
 2f89ZVXWrfSNZ5Gj3Tr6ouJW4stB6hQg73yL73xqAd3h1J88KSzORF7aloVpU6wRvLQkGjxzp
 Nl3yVq9Yfnpr1oVqQ0AnATRPdGKsHdpSVKT/afzFQXfXuWspQTAci65dkCKmCkxfH04JTecDd
 Jgcz3ynA+vtMmVVKPtnQipUSTcvurhuW7ZaDnXZMLavmFAgNbEleAEEhP/0UIpZR27ty0OPEO
 7JSovAJNiEeIBZVZDqQGNHpEk2Q=

>>> Static structs are initialized with zeros for unspecified fields.
>>> So there is no advantage to explicitly initialize .remove with NULL
>>> and the assignment can be dropped without side effects.
>>
>> Would you become interested to delete redundant initialisation repetiti=
ons
>> at any more source code places?
>>
>> A corresponding script for the semantic patch language (Coccinelle soft=
ware)
>> can point more remaining update candidates out for various components.
>
> Coccinelle shows 471 files.

I got the impression that more source code places can be reconsidered acco=
rdingly.

@deletion@
identifier member, s, var;
@@
 static struct s var =3D
 {
 ...,
-.member =3D \( 0 \| NULL \) ,
 ...
 };


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> rg '^-\s' =E2=
=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/delete_NULL_assignment_in_sta=
tic_struct-20231117.diff | wc -l
6567

Regards,
Markus

