Return-Path: <linux-spi+bounces-8073-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EDAAB31BE
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 10:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838361891819
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334ED259CB5;
	Mon, 12 May 2025 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A7It7FKp"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF725A2AE;
	Mon, 12 May 2025 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038756; cv=none; b=KDpyTVhqYMHAW830BYoYwW+5HFqSd6SmWGD6ass8VPgtdVogqaUKLB+6c25hjqnXpJBmUKaOVpvlQLH7NRrsshBUSgCEoILv4C2V0GJyDDiBTStx9B01XrzD1d255S/pfH0l+UMUzm3I9mkbGDJOomjEj2KClc3R6CLw+nExbcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038756; c=relaxed/simple;
	bh=ADK2OK+ChL7DrngabZZFHdRVILAcBiI1snBCJx8n6FU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ddzHaeHv2GBedV26hA7veBK+Ln6zE8CtLMdY0Gk0sXs5BI80/frPVkGK/Vz7U0Df+A0rWapKn3aucUoQdxuNzsaiQGXBDr+1cFHfDV7LamLYto6JAy3Kk70smfW/Om79AcTNGUZG4de0Mr5RUhwf/AHV823Rwy81Ns+DC9InzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A7It7FKp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B04343159;
	Mon, 12 May 2025 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747038745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25cSWVOEKZ1VP77Jx5jaMaLaHYR9JlnvU1JHD3mwYw8=;
	b=A7It7FKpj3JBU9iHEedfI0AtnqV5K5aUOigplK8DMO6OtHlxL8DtqxNhP9SjQXFyF8LsmD
	iayCCKqUUGA3CvMJ4/j6AzPjT4uuNHnG0fYuRQElk2uX+wbDJLvR/qec/zIadkI/8GQwdQ
	N+jI4XHw5Sgv0mOk+ZOpT5gTJ1YtYFUl6ut4AWu4rp5Iywb6vArZTyKzb1aEW6ZoO+j8FT
	N8VCBlq3nGw7Ch7JJXuKkxVxh7wkDPpKiIj+GV0iXBZFPsV4ENOWgv/Y3jBUKxAwui9uEw
	t5u30FQcL4qQc62SQYBgAa3D1+1y2lRdZi10LXNfgYncIKu3jhSBy3SXz+nswA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>,  Mark Brown
 <broonie@kernel.org>,  Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Varadarajan Narayanan
 <quic_varada@quicinc.com>,  Sricharan Ramabadhran
 <quic_srichara@quicinc.com>,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-arm-msm@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/2] spi: spi-qpic-snand: add support for 8 bits
 ECC strength
In-Reply-To: <c1729d39-9f7f-4c6d-b8a4-72dfee4bfca5@gmail.com> (Gabor Juhos's
	message of "Mon, 5 May 2025 15:21:52 +0200")
References: <20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com>
	<20250502-qpic-snand-8bit-ecc-v1-2-95f3cd08bbc5@gmail.com>
	<8aa3d4da-da3e-2af4-e0f9-cd56d6259d8f@quicinc.com>
	<c1729d39-9f7f-4c6d-b8a4-72dfee4bfca5@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 12 May 2025 10:32:23 +0200
Message-ID: <878qn2nsa0.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehjgehgkeihjeesghhmrghilhdrtghomhdprhgtphhtthhopehquhhitggpmhgurghlrghmsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhivhgrnhhnrghnrdhsrgguhhgrshhivhgrmheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhto
 hepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehquhhitggpvhgrrhgruggrsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhitghhrghrrgesqhhuihgtihhntgdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On 05/05/2025 at 15:21:52 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:

> 2025. 05. 05. 13:17 keltez=C3=A9ssel, Md Sadre Alam =C3=ADrta:
>>=20
>>=20
>
> [...]
>
>>> =C2=A0=C2=A0 [ 2720.344163] mtd_stresstest: 8192 operations done
>>> =C2=A0=C2=A0 [ 2761.645640] mtd_stresstest: 9216 operations done
>>> =C2=A0=C2=A0 [ 2791.760534] mtd_stresstest: finished, 10000 operations =
done
>>> =C2=A0=C2=A0 [ 2791.760817] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> =C2=A0=C2=A0 #
>> Could you please run biterror test "mtd_nandbiterrs" with the same devic=
e, since
>> you are adding 8-bit ECC support.
>
> Sure, here is the result:
>
> # insmod mtd_test
> # for i in $(seq 0 4); do insmod mtd_nandbiterrs; done
> [   45.405610]
> [   45.405638] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [   45.406164] mtd_nandbiterrs: MTD device: 0
> [   45.411807] mtd_nandbiterrs: MTD device size 268435456, eraseblock=3D1=
31072,
> page=3D2048, oob=3D128
> [   45.415990] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
> [   45.424495] mtd_nandbiterrs: Using page=3D0, offset=3D0, eraseblock=3D0
> [   45.434686] mtd_nandbiterrs: incremental biterrors test
> [   45.436653] mtd_nandbiterrs: write_page
> [   45.442634] mtd_nandbiterrs: rewrite page
> [   45.446408] mtd_nandbiterrs: read_page
> [   45.450346] mtd_nandbiterrs: verify_page
> [   45.453320] mtd_nandbiterrs: Successfully corrected 0 bit errors per s=
ubpage
> [   45.457405] mtd_nandbiterrs: Inserted biterror @ 0/5
> [   45.464431] mtd_nandbiterrs: rewrite page
> [   45.470216] mtd_nandbiterrs: read_page
> [   45.473852] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   45.476909] mtd_nandbiterrs: verify_page
> [   45.483090] mtd_nandbiterrs: Successfully corrected 1 bit errors per s=
ubpage
> [   45.487098] mtd_nandbiterrs: Inserted biterror @ 0/2
> [   45.494111] mtd_nandbiterrs: rewrite page
> [   45.499850] mtd_nandbiterrs: read_page
> [   45.503557] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   45.506597] mtd_nandbiterrs: verify_page
> [   45.512777] mtd_nandbiterrs: Successfully corrected 2 bit errors per s=
ubpage
> [   45.516768] mtd_nandbiterrs: Inserted biterror @ 0/0
> [   45.523810] mtd_nandbiterrs: rewrite page
> [   45.529586] mtd_nandbiterrs: read_page
> [   45.533224] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   45.536305] mtd_nandbiterrs: verify_page
> [   45.542464] mtd_nandbiterrs: Successfully corrected 3 bit errors per s=
ubpage
> [   45.546457] mtd_nandbiterrs: Inserted biterror @ 1/7
> [   45.553470] mtd_nandbiterrs: rewrite page
> [   45.559244] mtd_nandbiterrs: read_page
> [   45.562914] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   45.565991] mtd_nandbiterrs: verify_page
> [   45.572153] mtd_nandbiterrs: Successfully corrected 4 bit errors per s=
ubpage
> [   45.576142] mtd_nandbiterrs: Inserted biterror @ 1/5
> [   45.583158] mtd_nandbiterrs: rewrite page
> [   45.588927] mtd_nandbiterrs: read_page
> [   45.592599] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   45.595680] mtd_nandbiterrs: verify_page
> [   45.601840] mtd_nandbiterrs: Successfully corrected 5 bit errors per s=
ubpage
> [   45.605831] mtd_nandbiterrs: Inserted biterror @ 1/2
> [   45.612846] mtd_nandbiterrs: rewrite page
> [   45.618618] mtd_nandbiterrs: read_page
> [   45.622286] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   45.625434] mtd_nandbiterrs: verify_page
> [   45.631528] mtd_nandbiterrs: Successfully corrected 6 bit errors per s=
ubpage
> [   45.635517] mtd_nandbiterrs: Inserted biterror @ 1/0
> [   45.642533] mtd_nandbiterrs: rewrite page
> [   45.648303] mtd_nandbiterrs: read_page
> [   45.651975] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   45.655055] mtd_nandbiterrs: verify_page
> [   45.661215] mtd_nandbiterrs: Successfully corrected 7 bit errors per s=
ubpage
> [   45.665207] mtd_nandbiterrs: Inserted biterror @ 2/6
> [   45.672221] mtd_nandbiterrs: rewrite page
> [   45.677987] mtd_nandbiterrs: read_page
> [   45.681663] mtd_nandbiterrs: Read reported 3 corrected bit errors
> [   45.684741] mtd_nandbiterrs: verify_page
> [   45.690902] mtd_nandbiterrs: Successfully corrected 8 bit errors per s=
ubpage
> [   45.694892] mtd_nandbiterrs: Inserted biterror @ 2/5
> [   45.701908] mtd_nandbiterrs: rewrite page
> [   45.707678] mtd_nandbiterrs: read_page
> [   45.711351] mtd_nandbiterrs: error: read failed at 0x0
> [   45.714431] mtd_nandbiterrs: After 9 biterrors per subpage, read repor=
ted
> error -74
> [   45.722975] mtd_nandbiterrs: finished successfully.
> [   45.727101] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [   46.200485]
> [   46.200512] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [   46.201039] mtd_nandbiterrs: MTD device: 0
> [   46.206751] mtd_nandbiterrs: MTD device size 268435456, eraseblock=3D1=
31072,
> page=3D2048, oob=3D128
> [   46.210763] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
> [   46.219377] mtd_nandbiterrs: Using page=3D0, offset=3D0, eraseblock=3D0
> [   46.228941] mtd_nandbiterrs: incremental biterrors test
> [   46.231522] mtd_nandbiterrs: write_page
> [   46.237524] mtd_nandbiterrs: rewrite page
> [   46.241199] mtd_nandbiterrs: read_page
> [   46.245175] mtd_nandbiterrs: verify_page
> [   46.248195] mtd_nandbiterrs: Successfully corrected 0 bit errors per s=
ubpage
> [   46.252254] mtd_nandbiterrs: Inserted biterror @ 0/5
> [   46.259317] mtd_nandbiterrs: rewrite page
> [   46.265230] mtd_nandbiterrs: read_page
> [   46.268955] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   46.271784] mtd_nandbiterrs: verify_page
> [   46.277987] mtd_nandbiterrs: Successfully corrected 1 bit errors per s=
ubpage
> [   46.281941] mtd_nandbiterrs: Inserted biterror @ 0/2
> [   46.288985] mtd_nandbiterrs: rewrite page
> [   46.294803] mtd_nandbiterrs: read_page
> [   46.298414] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   46.301472] mtd_nandbiterrs: verify_page
> [   46.307677] mtd_nandbiterrs: Successfully corrected 2 bit errors per s=
ubpage
> [   46.311629] mtd_nandbiterrs: Inserted biterror @ 0/0
> [   46.318686] mtd_nandbiterrs: rewrite page
> [   46.324470] mtd_nandbiterrs: read_page
> [   46.328100] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   46.331159] mtd_nandbiterrs: verify_page
> [   46.337371] mtd_nandbiterrs: Successfully corrected 3 bit errors per s=
ubpage
> [   46.341316] mtd_nandbiterrs: Inserted biterror @ 1/7
> [   46.348365] mtd_nandbiterrs: rewrite page
> [   46.354123] mtd_nandbiterrs: read_page
> [   46.357787] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   46.360846] mtd_nandbiterrs: verify_page
> [   46.367047] mtd_nandbiterrs: Successfully corrected 4 bit errors per s=
ubpage
> [   46.371003] mtd_nandbiterrs: Inserted biterror @ 1/5
> [   46.378046] mtd_nandbiterrs: rewrite page
> [   46.383794] mtd_nandbiterrs: read_page
> [   46.387475] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   46.390534] mtd_nandbiterrs: verify_page
> [   46.396747] mtd_nandbiterrs: Successfully corrected 5 bit errors per s=
ubpage
> [   46.400691] mtd_nandbiterrs: Inserted biterror @ 1/2
> [   46.407733] mtd_nandbiterrs: rewrite page
> [   46.413483] mtd_nandbiterrs: read_page
> [   46.417190] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   46.420222] mtd_nandbiterrs: verify_page
> [   46.426419] mtd_nandbiterrs: Successfully corrected 6 bit errors per s=
ubpage
> [   46.430379] mtd_nandbiterrs: Inserted biterror @ 1/0
> [   46.437423] mtd_nandbiterrs: rewrite page
> [   46.443168] mtd_nandbiterrs: read_page
> [   46.446875] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   46.449908] mtd_nandbiterrs: verify_page
> [   46.456109] mtd_nandbiterrs: Successfully corrected 7 bit errors per s=
ubpage
> [   46.460066] mtd_nandbiterrs: Inserted biterror @ 2/6
> [   46.467109] mtd_nandbiterrs: rewrite page
> [   46.472888] mtd_nandbiterrs: read_page
> [   46.476569] mtd_nandbiterrs: Read reported 3 corrected bit errors
> [   46.479597] mtd_nandbiterrs: verify_page
> [   46.485796] mtd_nandbiterrs: Successfully corrected 8 bit errors per s=
ubpage
> [   46.489753] mtd_nandbiterrs: Inserted biterror @ 2/5
> [   46.496797] mtd_nandbiterrs: rewrite page
> [   46.502540] mtd_nandbiterrs: read_page
> [   46.506249] mtd_nandbiterrs: error: read failed at 0x0
> [   46.509284] mtd_nandbiterrs: After 9 biterrors per subpage, read repor=
ted
> error -74
> [   46.517867] mtd_nandbiterrs: finished successfully.
> [   46.521956] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [   47.150313]
> [   47.150341] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [   47.150867] mtd_nandbiterrs: MTD device: 0
> [   47.156564] mtd_nandbiterrs: MTD device size 268435456, eraseblock=3D1=
31072,
> page=3D2048, oob=3D128
> [   47.160591] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
> [   47.169201] mtd_nandbiterrs: Using page=3D0, offset=3D0, eraseblock=3D0
> [   47.178778] mtd_nandbiterrs: incremental biterrors test
> [   47.181350] mtd_nandbiterrs: write_page
> [   47.187334] mtd_nandbiterrs: rewrite page
> [   47.191016] mtd_nandbiterrs: read_page
> [   47.194997] mtd_nandbiterrs: verify_page
> [   47.198019] mtd_nandbiterrs: Successfully corrected 0 bit errors per s=
ubpage
> [   47.202081] mtd_nandbiterrs: Inserted biterror @ 0/5
> [   47.209132] mtd_nandbiterrs: rewrite page
> [   47.214962] mtd_nandbiterrs: read_page
> [   47.218554] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   47.221612] mtd_nandbiterrs: verify_page
> [   47.227814] mtd_nandbiterrs: Successfully corrected 1 bit errors per s=
ubpage
> [   47.231769] mtd_nandbiterrs: Inserted biterror @ 0/2
> [   47.238816] mtd_nandbiterrs: rewrite page
> [   47.244574] mtd_nandbiterrs: read_page
> [   47.248242] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   47.251300] mtd_nandbiterrs: verify_page
> [   47.257499] mtd_nandbiterrs: Successfully corrected 2 bit errors per s=
ubpage
> [   47.261457] mtd_nandbiterrs: Inserted biterror @ 0/0
> [   47.268504] mtd_nandbiterrs: rewrite page
> [   47.274301] mtd_nandbiterrs: read_page
> [   47.277930] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   47.280987] mtd_nandbiterrs: verify_page
> [   47.287187] mtd_nandbiterrs: Successfully corrected 3 bit errors per s=
ubpage
> [   47.291145] mtd_nandbiterrs: Inserted biterror @ 1/7
> [   47.298191] mtd_nandbiterrs: rewrite page
> [   47.303951] mtd_nandbiterrs: read_page
> [   47.307619] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   47.310675] mtd_nandbiterrs: verify_page
> [   47.316876] mtd_nandbiterrs: Successfully corrected 4 bit errors per s=
ubpage
> [   47.320832] mtd_nandbiterrs: Inserted biterror @ 1/5
> [   47.327875] mtd_nandbiterrs: rewrite page
> [   47.333629] mtd_nandbiterrs: read_page
> [   47.337305] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   47.340362] mtd_nandbiterrs: verify_page
> [   47.346563] mtd_nandbiterrs: Successfully corrected 5 bit errors per s=
ubpage
> [   47.350519] mtd_nandbiterrs: Inserted biterror @ 1/2
> [   47.357561] mtd_nandbiterrs: rewrite page
> [   47.363310] mtd_nandbiterrs: read_page
> [   47.367021] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   47.370050] mtd_nandbiterrs: verify_page
> [   47.376248] mtd_nandbiterrs: Successfully corrected 6 bit errors per s=
ubpage
> [   47.380207] mtd_nandbiterrs: Inserted biterror @ 1/0
> [   47.387250] mtd_nandbiterrs: rewrite page
> [   47.392996] mtd_nandbiterrs: read_page
> [   47.396703] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   47.399737] mtd_nandbiterrs: verify_page
> [   47.405936] mtd_nandbiterrs: Successfully corrected 7 bit errors per s=
ubpage
> [   47.409894] mtd_nandbiterrs: Inserted biterror @ 2/6
> [   47.416938] mtd_nandbiterrs: rewrite page
> [   47.422685] mtd_nandbiterrs: read_page
> [   47.426387] mtd_nandbiterrs: Read reported 3 corrected bit errors
> [   47.429424] mtd_nandbiterrs: verify_page
> [   47.435637] mtd_nandbiterrs: Successfully corrected 8 bit errors per s=
ubpage
> [   47.439582] mtd_nandbiterrs: Inserted biterror @ 2/5
> [   47.446624] mtd_nandbiterrs: rewrite page
> [   47.452369] mtd_nandbiterrs: read_page
> [   47.456080] mtd_nandbiterrs: error: read failed at 0x0
> [   47.459111] mtd_nandbiterrs: After 9 biterrors per subpage, read repor=
ted
> error -74
> [   47.467699] mtd_nandbiterrs: finished successfully.
> [   47.471784] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [   48.080311]
> [   48.080339] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [   48.080866] mtd_nandbiterrs: MTD device: 0
> [   48.086560] mtd_nandbiterrs: MTD device size 268435456, eraseblock=3D1=
31072,
> page=3D2048, oob=3D128
> [   48.090590] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
> [   48.099204] mtd_nandbiterrs: Using page=3D0, offset=3D0, eraseblock=3D0
> [   48.108765] mtd_nandbiterrs: incremental biterrors test
> [   48.111353] mtd_nandbiterrs: write_page
> [   48.117325] mtd_nandbiterrs: rewrite page
> [   48.121017] mtd_nandbiterrs: read_page
> [   48.124996] mtd_nandbiterrs: verify_page
> [   48.128017] mtd_nandbiterrs: Successfully corrected 0 bit errors per s=
ubpage
> [   48.132080] mtd_nandbiterrs: Inserted biterror @ 0/5
> [   48.139131] mtd_nandbiterrs: rewrite page
> [   48.144881] mtd_nandbiterrs: read_page
> [   48.148552] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   48.151611] mtd_nandbiterrs: verify_page
> [   48.157816] mtd_nandbiterrs: Successfully corrected 1 bit errors per s=
ubpage
> [   48.161768] mtd_nandbiterrs: Inserted biterror @ 0/2
> [   48.168891] mtd_nandbiterrs: rewrite page
> [   48.174571] mtd_nandbiterrs: read_page
> [   48.178241] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   48.181299] mtd_nandbiterrs: verify_page
> [   48.187500] mtd_nandbiterrs: Successfully corrected 2 bit errors per s=
ubpage
> [   48.191455] mtd_nandbiterrs: Inserted biterror @ 0/0
> [   48.198506] mtd_nandbiterrs: rewrite page
> [   48.204299] mtd_nandbiterrs: read_page
> [   48.207931] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   48.210985] mtd_nandbiterrs: verify_page
> [   48.217187] mtd_nandbiterrs: Successfully corrected 3 bit errors per s=
ubpage
> [   48.221142] mtd_nandbiterrs: Inserted biterror @ 1/7
> [   48.228188] mtd_nandbiterrs: rewrite page
> [   48.233950] mtd_nandbiterrs: read_page
> [   48.237617] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   48.240673] mtd_nandbiterrs: verify_page
> [   48.246872] mtd_nandbiterrs: Successfully corrected 4 bit errors per s=
ubpage
> [   48.250831] mtd_nandbiterrs: Inserted biterror @ 1/5
> [   48.257875] mtd_nandbiterrs: rewrite page
> [   48.263631] mtd_nandbiterrs: read_page
> [   48.267303] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   48.270361] mtd_nandbiterrs: verify_page
> [   48.276560] mtd_nandbiterrs: Successfully corrected 5 bit errors per s=
ubpage
> [   48.280531] mtd_nandbiterrs: Inserted biterror @ 1/2
> [   48.287592] mtd_nandbiterrs: rewrite page
> [   48.293338] mtd_nandbiterrs: read_page
> [   48.297030] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   48.300049] mtd_nandbiterrs: verify_page
> [   48.306247] mtd_nandbiterrs: Successfully corrected 6 bit errors per s=
ubpage
> [   48.310205] mtd_nandbiterrs: Inserted biterror @ 1/0
> [   48.317250] mtd_nandbiterrs: rewrite page
> [   48.322994] mtd_nandbiterrs: read_page
> [   48.326705] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   48.329736] mtd_nandbiterrs: verify_page
> [   48.335935] mtd_nandbiterrs: Successfully corrected 7 bit errors per s=
ubpage
> [   48.339892] mtd_nandbiterrs: Inserted biterror @ 2/6
> [   48.346936] mtd_nandbiterrs: rewrite page
> [   48.352633] mtd_nandbiterrs: read_page
> [   48.356391] mtd_nandbiterrs: Read reported 3 corrected bit errors
> [   48.359423] mtd_nandbiterrs: verify_page
> [   48.365626] mtd_nandbiterrs: Successfully corrected 8 bit errors per s=
ubpage
> [   48.369581] mtd_nandbiterrs: Inserted biterror @ 2/5
> [   48.376627] mtd_nandbiterrs: rewrite page
> [   48.382322] mtd_nandbiterrs: read_page
> [   48.386077] mtd_nandbiterrs: error: read failed at 0x0
> [   48.389110] mtd_nandbiterrs: After 9 biterrors per subpage, read repor=
ted
> error -74
> [   48.397695] mtd_nandbiterrs: finished successfully.
> [   48.401783] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [   48.940558]
> [   48.940586] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [   48.941112] mtd_nandbiterrs: MTD device: 0
> [   48.946811] mtd_nandbiterrs: MTD device size 268435456, eraseblock=3D1=
31072,
> page=3D2048, oob=3D128
> [   48.950837] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
> [   48.959448] mtd_nandbiterrs: Using page=3D0, offset=3D0, eraseblock=3D0
> [   48.969014] mtd_nandbiterrs: incremental biterrors test
> [   48.971596] mtd_nandbiterrs: write_page
> [   48.977594] mtd_nandbiterrs: rewrite page
> [   48.981277] mtd_nandbiterrs: read_page
> [   48.985247] mtd_nandbiterrs: verify_page
> [   48.988269] mtd_nandbiterrs: Successfully corrected 0 bit errors per s=
ubpage
> [   48.992327] mtd_nandbiterrs: Inserted biterror @ 0/5
> [   48.999428] mtd_nandbiterrs: rewrite page
> [   49.005508] mtd_nandbiterrs: read_page
> [   49.008836] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   49.011858] mtd_nandbiterrs: verify_page
> [   49.018061] mtd_nandbiterrs: Successfully corrected 1 bit errors per s=
ubpage
> [   49.022015] mtd_nandbiterrs: Inserted biterror @ 0/2
> [   49.029058] mtd_nandbiterrs: rewrite page
> [   49.034848] mtd_nandbiterrs: read_page
> [   49.038516] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   49.041545] mtd_nandbiterrs: verify_page
> [   49.047755] mtd_nandbiterrs: Successfully corrected 2 bit errors per s=
ubpage
> [   49.051702] mtd_nandbiterrs: Inserted biterror @ 0/0
> [   49.058760] mtd_nandbiterrs: rewrite page
> [   49.064565] mtd_nandbiterrs: read_page
> [   49.068203] mtd_nandbiterrs: Read reported 1 corrected bit errors
> [   49.071232] mtd_nandbiterrs: verify_page
> [   49.077432] mtd_nandbiterrs: Successfully corrected 3 bit errors per s=
ubpage
> [   49.081389] mtd_nandbiterrs: Inserted biterror @ 1/7
> [   49.088432] mtd_nandbiterrs: rewrite page
> [   49.094197] mtd_nandbiterrs: read_page
> [   49.097889] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   49.100919] mtd_nandbiterrs: verify_page
> [   49.107121] mtd_nandbiterrs: Successfully corrected 4 bit errors per s=
ubpage
> [   49.111077] mtd_nandbiterrs: Inserted biterror @ 1/5
> [   49.118137] mtd_nandbiterrs: rewrite page
> [   49.123892] mtd_nandbiterrs: read_page
> [   49.127576] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   49.130608] mtd_nandbiterrs: verify_page
> [   49.136808] mtd_nandbiterrs: Successfully corrected 5 bit errors per s=
ubpage
> [   49.140764] mtd_nandbiterrs: Inserted biterror @ 1/2
> [   49.147807] mtd_nandbiterrs: rewrite page
> [   49.153607] mtd_nandbiterrs: read_page
> [   49.157268] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   49.160294] mtd_nandbiterrs: verify_page
> [   49.166496] mtd_nandbiterrs: Successfully corrected 6 bit errors per s=
ubpage
> [   49.170452] mtd_nandbiterrs: Inserted biterror @ 1/0
> [   49.177498] mtd_nandbiterrs: rewrite page
> [   49.183253] mtd_nandbiterrs: read_page
> [   49.186974] mtd_nandbiterrs: Read reported 2 corrected bit errors
> [   49.189983] mtd_nandbiterrs: verify_page
> [   49.196194] mtd_nandbiterrs: Successfully corrected 7 bit errors per s=
ubpage
> [   49.200140] mtd_nandbiterrs: Inserted biterror @ 2/6
> [   49.207182] mtd_nandbiterrs: rewrite page
> [   49.212895] mtd_nandbiterrs: read_page
> [   49.216671] mtd_nandbiterrs: Read reported 3 corrected bit errors
> [   49.219670] mtd_nandbiterrs: verify_page
> [   49.225872] mtd_nandbiterrs: Successfully corrected 8 bit errors per s=
ubpage
> [   49.229827] mtd_nandbiterrs: Inserted biterror @ 2/5
> [   49.236871] mtd_nandbiterrs: rewrite page
> [   49.242629] mtd_nandbiterrs: read_page
> [   49.246348] mtd_nandbiterrs: error: read failed at 0x0
> [   49.249356] mtd_nandbiterrs: After 9 biterrors per subpage, read repor=
ted
> error -74
> [   49.257958] mtd_nandbiterrs: finished successfully.
> [   49.262029] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> #

This is not the intended behavior. The reporting is wrong and should
report an increasing number of bitflips instead of 1, 1, 1, 2, 2, 2, 2,
3.

With this behavior, wear levelling will not work correctly.

This is not related to Gabor's changes, but I believe this should be
updated otherwise it does not make much sense to increase the strength.

Gabor, can you look into it? Both patches look fine otherwise, thanks a
lot!

Miqu=C3=A8l

