Return-Path: <linux-spi+bounces-8-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A796B7F280B
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 09:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61545281EF3
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE392111E;
	Tue, 21 Nov 2023 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mqSzAdvb"
X-Original-To: linux-spi@vger.kernel.org
X-Greylist: delayed 1960 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Nov 2023 00:52:12 PST
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA4F9;
	Tue, 21 Nov 2023 00:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700556716; x=1701161516; i=markus.elfring@web.de;
	bh=w1nXVLBpNtN58NGTg1Hi1tEZ2hWuodlftXNjiZP5OF4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=mqSzAdvbebRDgbZ5hogWE9yDICGyuFuQ4pXTqbv+efecXKaHmPfv3uCe5eDNSBnS
	 +W1qKYhemzAjqQPouxrz++zAVHeeTIlEOGU2vpHtsx9PZ+UTxnnxyE+442q1/x16m
	 dyWHG/bQ+X7Vd/C+gjEPNP9D11BPoQ9UVW1wd7J+f8Nggm61xCUl0eiSf72HfUAk1
	 GEekjf77TwJiKgwrWQKvgfrFu2CdUIlInMm/CGuOnIl3ICh6LN0oUfLlkrHIwaO3b
	 jiySzpNc2BtG4zHcR/8MiuwfppSYGsd3SBc/NFiM3Ei1tiKfZVijV3ELVNWBRGmqX
	 Q9GvJPWYf0llj2zf4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjgXH-1rm4gK3yaR-00l9g4; Tue, 21
 Nov 2023 09:51:55 +0100
Message-ID: <bd627a83-9c9e-451c-a3d6-84e90d40dadd@web.de>
Date: Tue, 21 Nov 2023 09:51:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: spi: cadence-xspi: Drop useless assignment to NULL
Content-Language: en-GB
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kernel@pengutronix.de, kernel-janitors@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Amit Dhingra <mechanicalamit@gmail.com>
References: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
 <233689d7-9409-406b-9383-49f10cd29336@web.de>
 <CAO=gReGA17gHSr4ftN1Jwrjt5t76oAgaL6+n6X4wD0osJnuq4g@mail.gmail.com>
 <53db2c8f-7b9b-47f7-89ba-d78584c12d7b@web.de>
 <20231121075716.it3cpwhwymkaqjrh@pengutronix.de>
 <3e4c0c06-9681-43df-be12-b2bbc599fdfb@web.de>
 <20231121083246.wg5qtej6cll3snlg@pengutronix.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231121083246.wg5qtej6cll3snlg@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6OEugY/ccCMmSnnu1bYO8xVAfnx6gvIBwDrAqb+qR3qedlB/UHI
 /qBKpNxD3e41NeMDkVerg5jTnJPv4zydPwmn1FGlK9P1HgQsXUCU4/VoxAz54Qpkg9Of3Cm
 24ScyeUL3M9carLfB3gkonoko1vbh2pqsC/U6HUbHp9r4wYuo7cz6R6SEvQceR8OYLoImGv
 MWnkPorK676dMX5TTk8xg==
UI-OutboundReport: notjunk:1;M01:P0:OlBcnwh/aaI=;AiaBSDMaGWuUA6LKuDWeuGQF1Es
 W5Sx+PzOiMWNrXpJSRjdvuRxrGCMvk3h0K/R02Mn3vtHTyGZEIOw27SyUlzeIPwEa8irDGdwo
 qYsT0zhfnEPHpQcx6FQXtWOShKiwmgrvH/NQnHwi69Ivm9oQuInyQMI33OxxMDG7ynly4qH7Y
 tLURTKWmYXWU0ZF0ZjMwxYWdMfdxSA1PtlurcN2Mye9Ei4dkkFXnEqtgnszmSiRM/vzE8JKWB
 CJHlIxikArJg8GDgz8TB60+bO1NgsSzaAdlxwq5mc64+S3pDGTsrWwVyDNPlX5StjMmaIfnab
 MO5/ICB5e1hlTnk5gY/iGzOq3nAWl1wYbfq0fw0kqwVkdLSzcwal4tCv2inhnFl02fAchi8WS
 M3iyIoh6xKLltPStRCzbqTt+6zTixgFF30YkHfC6rtCVZAvTL48ACHwbKTfHJbInQq+4X2kuD
 6w373WtDCmxuwnNFK60Aqjq6X08uYEiLXGm4q13hlWg/Rs1dCF26LeRdpDupfKyzPoEqzuLUt
 Li5H44Yc+WCWd99Gtb77fFy6j0/DmfWt9AszVL2wWxGhiOVJD+dD/6bdsdlDl0aA0vNnEdaLa
 DrBnkqNcZmlYIG4PjC/kPI4fQmc/YGju5t4lBs1v1/U0YEcxLWoQW8eN+h5vxHsOj46kmOSeT
 nossqaQOTa2nfTaFCg+6tmOV+6gsboy2xkQAr93ieY1xRnIkwG2pX2jU/csF6g7HPmocvpTk9
 BQcDJGP3yGdQrmaaGmDxJsKTBRTP9tMhVN1CFMCMOHkuSiGyWTNBgB/eyYWX3yOfcgo0Ktari
 ivBxx3lOSL9D8JR9giWJGVCmbDEHp47xnLA+5tECvnlDDvcGDuSOLlvo2erfA10IUMY5/UV5V
 dTUBjeauZ/gbtV1IuDj0VtFWz/mP9Tyvb2kgxx5WXBe5HigmxJXGUYUHMzqt0n2s5AnnVKPwZ
 IhSYUQ==

>>>>>>> Static structs are initialized with zeros for unspecified fields.
>>>>>>> So there is no advantage to explicitly initialize .remove with NUL=
L
>>>>>>> and the assignment can be dropped without side effects.
=E2=80=A6
>  static const struct samsung_pwm_variant s5pc100_variant =3D {
>  	.bits		=3D 32,
> -	.div_base	=3D 0,
>  	.has_tint_cstat	=3D true,
>  	.tclk_mask	=3D BIT(5),
>  };
>
> If I saw the resulting code, I'd wonder about the missing assignments
> in these three structs.

How would you get doubts here if you can depend on the well defined initia=
lisation
for unspecified members of static data structure variables?


> So IMHO the status quo is better even though it is more verbose.

Are any design conflicts involved here?

Will the Linux coding style evolve accordingly?

Regards,
Markus

