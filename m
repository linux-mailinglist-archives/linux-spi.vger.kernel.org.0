Return-Path: <linux-spi+bounces-6-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA647F2767
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 09:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5124D1C21870
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 08:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC03AC04;
	Tue, 21 Nov 2023 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Kx8DZmW3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF1795;
	Tue, 21 Nov 2023 00:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700555124; x=1701159924; i=markus.elfring@web.de;
	bh=0HuhZKyogmP5HakjyzCDzZGEHladzcsYKX5THh5ZTYU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Kx8DZmW33uL/7Iynn5OoHUYltR17QZYFydBouHSHcrfapfk0ntN75a2lWvJpwEg1
	 nwV0PSK/R3jGc9Fiszlj617tryY9OQqAnF5UPIZfcSjF08K6AMpDyEMdy8ycRwnBj
	 eTTfNVv9n8l/ii+Khu88Dun/jbVz4/BC6EUAEEiei+WRpVccqfkVcDqRaPTeL7P5a
	 G356/KlIgqkNn+60BRB4Prs7InvIdYA8bN+nA2ATqe7I+/N0erbqy34AOliTIGWYI
	 qf3Hck9KPmeSCJKB+3owb2A5j51/AI4dvIYnhMdojVcz5NavCPpzPMVqOifm664M1
	 wq+JSCDmv4DRO0LJxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRMB-1rXpZl1pSJ-00hmdQ; Tue, 21
 Nov 2023 09:19:14 +0100
Message-ID: <3e4c0c06-9681-43df-be12-b2bbc599fdfb@web.de>
Date: Tue, 21 Nov 2023 09:19:13 +0100
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
Cc: Amit Dhingra <mechanicalamit@gmail.com>, Mark Brown <broonie@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org,
 cocci@inria.fr
References: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
 <233689d7-9409-406b-9383-49f10cd29336@web.de>
 <CAO=gReGA17gHSr4ftN1Jwrjt5t76oAgaL6+n6X4wD0osJnuq4g@mail.gmail.com>
 <53db2c8f-7b9b-47f7-89ba-d78584c12d7b@web.de>
 <20231121075716.it3cpwhwymkaqjrh@pengutronix.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231121075716.it3cpwhwymkaqjrh@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gooUD8s2uK98dBRyL1W1Lxel6QcDCzCZtGlfKnGzZZhof1iMf5s
 qy4fXsnhagtd9E1FKnFubv6+pPsRFesbE+7a8xWweot1NKxUbhuNNB5ozXB9wBhkBIQti7o
 MCMueIWEWIN027qE6gKqhD0lFrkzwC5nK1/b/swUX94XS46DSX+FhU7HhyS57WbRj1yiVlf
 p2lSceIusomEUDCImWbxQ==
UI-OutboundReport: notjunk:1;M01:P0:oZJ1MnV5Ahs=;ba7+ybBjVVSJGQ6c477i1utamC3
 FNYQwksSFN1hCUsiD8P0KTu2tW55R4ownHRZpSKnuuHL74wvg59/pc65zJevhazgnb19CEXBx
 Boh4OZNrB44juCS4a52ZZ07Kh6G4h90m6bzetVyWpbS9BfrdkZsWe3pv55WIz+4gaPwbUWMlh
 H5GOF8SNH+XDkOlxLLteL0Hlp6ihmwEkV+iMNHLo1TB6WxJiQu9/m6X2O+kNvraim9aEvRZsH
 weYBjbKprk/hcv7Lyio5U1bs3I9H5SyhOfoCBiBEN6oi6CiJ885AzcMaGvteLAH+DdTK4u+eT
 nzaoK341N8r6MyywI9s1pv5QWcj+xPna19uCor/S6wBFdQsBnux57/oqafpRl3uK+tatgFOY1
 UV2Czu5xMYKIN5gso4T+Qdma3Y2bLOGvWRryEwZlDSMdS407pLdC9cEeycpUr9eSWSHSqzeGH
 egXzuHjs1L8dzxAhcNnyrseJbKBGezd+CgpgGPT4e+Hewbx2aU5g6zamWtatNqolEWDJngchg
 Zy9Py35MLLy1RSoZq/RSSMrHmtzDArVBjHyO0MuZzczEUXzuY2TsqyT/k0V6TEaUCR3KYBgJu
 jai3olU2CA2GTngdMVu9xP5LZNos05zQC3iNC0UZumlf9KmJ8Ic+tXFa34V5yM4FRLAAi8yov
 rxG37UOeQelknQyAp4T1zX0irUyVWy/8xDfAUE8mWSeqGDsJQMuKuS89aBw6zXyXhq5esqm64
 ONVzldh5CGd/2USFk7KaRF25n9ZUlgET8R1NyUB6FMpHbCf63cvSMOTzIwF9rNV72TJZiNRG2
 sNFAujfsDyu/ipZ3IoIH0YaKloXX4hBGxZH9fgTwv5kdSSiyPr3XeWiE+AsqqUvIVGgeiQc22
 DcLvRbGGXsAz+1skJMINssJPeAzHlaY016hR695n6AN6ctvyZkBHKjZ019fVoMCNRQnRGpHb/
 SiKePw==

>>>>> Static structs are initialized with zeros for unspecified fields.
>>>>> So there is no advantage to explicitly initialize .remove with NULL
>>>>> and the assignment can be dropped without side effects.
=E2=80=A6
> Removing =3D 0 assignments should be carefully reviewed. I skimmed the
> changes to drivers/pwm and would oppose to both changes.

How does this development view fit to information from the patch descripti=
on?


> Even for my patch I wasn't sure if it's a good idea and talked to Mark b=
efore
> sending it.

Would you get concerned that null pointers would eventually be represented
by non-zero values on any execution platform?

* https://en.cppreference.com/w/c/language/nullptr

* https://c-faq.com/null/machexamp.html

* https://stackoverflow.com/questions/2759845/why-is-address-zero-used-for=
-the-null-pointer


Regards,
Markus

