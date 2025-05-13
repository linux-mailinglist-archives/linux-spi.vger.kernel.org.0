Return-Path: <linux-spi+bounces-8102-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C2FAB4CCA
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 09:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25413A8861
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4D78F4B;
	Tue, 13 May 2025 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DzSPwzA/"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113C03FBA7;
	Tue, 13 May 2025 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121563; cv=none; b=RaLsWXfjn0jZd8SeZavWwMGz/UNTFJssGnA4crw6AzcUqf0esl//UKJHodzRl18LeQFjxyqNd5Fg5bWJzPQgJcDpFJ+E0H6Qx5TKfcjhie7eHwiYf24zup9JrH3EhJTB7LKAjl3fXH2b6FhZXmvCwD2LHwXRicO7CIp8s5Nm1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121563; c=relaxed/simple;
	bh=XdkMb5Q4N9HN1sk1j3MYurYl2fcKG++Bwa2mmv+dmnk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lOy3btTsfM8ksMAd5S8VyYLoTYrLuYM2hWRo4b6nNClobLsu9R2VPaM8URXfkNhYsnD/3yoajjFukhXbVeEOW87UQDPN8mxOtIja2RIZJ9J6ygbp8UVLBDFwgO5wGmdxOefeS64YkwRSdN8+SVJkshy13zYX1LS3SDplutPyLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DzSPwzA/; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C36D543A52;
	Tue, 13 May 2025 07:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747121558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1eIbRBwjMlG5tI3/9yXhq2Ez/OQmBnIGc8nf+riz4A=;
	b=DzSPwzA/yAJo+uAUajyB277KUwu4PQMAGG2Ig4Cu1p7h1x4qSpGI0wErko+p1d3dK84NYp
	VTzleB7hB7BhaNKeSbSPVRPRwYOfR8frcl+9RqcIyDJ2N0XVRNUf5ilFbL31dUuvomULms
	AYy1xGLOIO9hwNr7KBS7Y1YvZa+ahoAEofZ4I0VHf/pVzQHRcPWHjKI0vwI8AregYsLyBn
	3iU/wSawUqyHapQexJKjBy070S0bb4PznS/JmptKy5GAy1Aw5gDE9/uSLaTK5/7UYpva/n
	fwLf5jh7F/xLOQDu7lKIUREXVUxSzmZ9DkKw3YQ/PBNdzFQ+kMc8ymPn18nURA==
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
In-Reply-To: <16195524-1f31-4968-a3fd-f3d24f1c4223@gmail.com> (Gabor Juhos's
	message of "Mon, 12 May 2025 22:19:05 +0200")
References: <20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com>
	<20250502-qpic-snand-8bit-ecc-v1-2-95f3cd08bbc5@gmail.com>
	<8aa3d4da-da3e-2af4-e0f9-cd56d6259d8f@quicinc.com>
	<c1729d39-9f7f-4c6d-b8a4-72dfee4bfca5@gmail.com>
	<878qn2nsa0.fsf@bootlin.com>
	<16195524-1f31-4968-a3fd-f3d24f1c4223@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 13 May 2025 09:32:36 +0200
Message-ID: <87msbhezjf.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehjgehgkeihjeesghhmrghilhdrtghomhdprhgtphhtthhopehquhhitggpmhgurghlrghmsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhivhgrnhhnrghnrdhsrgguhhgrshhivhgrmheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhto
 hepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehquhhitggpvhgrrhgruggrsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhitghhrghrrgesqhhuihgtihhntgdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On 12/05/2025 at 22:19:05 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:

> 2025. 05. 12. 10:32 keltez=C3=A9ssel, Miquel Raynal =C3=ADrta:
>> On 05/05/2025 at 15:21:52 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:
>>=20
>>> 2025. 05. 05. 13:17 keltez=C3=A9ssel, Md Sadre Alam =C3=ADrta:
>>>>
>>>>
>>>
>
> [...]
>
>>> [   48.940586] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>> [   48.941112] mtd_nandbiterrs: MTD device: 0
>>> [   48.946811] mtd_nandbiterrs: MTD device size 268435456, eraseblock=
=3D131072,
>>> page=3D2048, oob=3D128
>>> [   48.950837] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
>>> [   48.959448] mtd_nandbiterrs: Using page=3D0, offset=3D0, eraseblock=
=3D0
>>> [   48.969014] mtd_nandbiterrs: incremental biterrors test
>>> [   48.971596] mtd_nandbiterrs: write_page
>>> [   48.977594] mtd_nandbiterrs: rewrite page
>>> [   48.981277] mtd_nandbiterrs: read_page
>>> [   48.985247] mtd_nandbiterrs: verify_page
>>> [   48.988269] mtd_nandbiterrs: Successfully corrected 0 bit errors per=
 subpage
>>> [   48.992327] mtd_nandbiterrs: Inserted biterror @ 0/5
>>> [   48.999428] mtd_nandbiterrs: rewrite page
>>> [   49.005508] mtd_nandbiterrs: read_page
>>> [   49.008836] mtd_nandbiterrs: Read reported 1 corrected bit errors
>>> [   49.011858] mtd_nandbiterrs: verify_page
>>> [   49.018061] mtd_nandbiterrs: Successfully corrected 1 bit errors per=
 subpage
>>> [   49.022015] mtd_nandbiterrs: Inserted biterror @ 0/2
>>> [   49.029058] mtd_nandbiterrs: rewrite page
>>> [   49.034848] mtd_nandbiterrs: read_page
>>> [   49.038516] mtd_nandbiterrs: Read reported 1 corrected bit errors
>>> [   49.041545] mtd_nandbiterrs: verify_page
>>> [   49.047755] mtd_nandbiterrs: Successfully corrected 2 bit errors per=
 subpage
>>> [   49.051702] mtd_nandbiterrs: Inserted biterror @ 0/0
>>> [   49.058760] mtd_nandbiterrs: rewrite page
>>> [   49.064565] mtd_nandbiterrs: read_page
>>> [   49.068203] mtd_nandbiterrs: Read reported 1 corrected bit errors
>>> [   49.071232] mtd_nandbiterrs: verify_page
>>> [   49.077432] mtd_nandbiterrs: Successfully corrected 3 bit errors per=
 subpage
>>> [   49.081389] mtd_nandbiterrs: Inserted biterror @ 1/7
>>> [   49.088432] mtd_nandbiterrs: rewrite page
>>> [   49.094197] mtd_nandbiterrs: read_page
>>> [   49.097889] mtd_nandbiterrs: Read reported 2 corrected bit errors
>>> [   49.100919] mtd_nandbiterrs: verify_page
>>> [   49.107121] mtd_nandbiterrs: Successfully corrected 4 bit errors per=
 subpage
>>> [   49.111077] mtd_nandbiterrs: Inserted biterror @ 1/5
>>> [   49.118137] mtd_nandbiterrs: rewrite page
>>> [   49.123892] mtd_nandbiterrs: read_page
>>> [   49.127576] mtd_nandbiterrs: Read reported 2 corrected bit errors
>>> [   49.130608] mtd_nandbiterrs: verify_page
>>> [   49.136808] mtd_nandbiterrs: Successfully corrected 5 bit errors per=
 subpage
>>> [   49.140764] mtd_nandbiterrs: Inserted biterror @ 1/2
>>> [   49.147807] mtd_nandbiterrs: rewrite page
>>> [   49.153607] mtd_nandbiterrs: read_page
>>> [   49.157268] mtd_nandbiterrs: Read reported 2 corrected bit errors
>>> [   49.160294] mtd_nandbiterrs: verify_page
>>> [   49.166496] mtd_nandbiterrs: Successfully corrected 6 bit errors per=
 subpage
>>> [   49.170452] mtd_nandbiterrs: Inserted biterror @ 1/0
>>> [   49.177498] mtd_nandbiterrs: rewrite page
>>> [   49.183253] mtd_nandbiterrs: read_page
>>> [   49.186974] mtd_nandbiterrs: Read reported 2 corrected bit errors
>>> [   49.189983] mtd_nandbiterrs: verify_page
>>> [   49.196194] mtd_nandbiterrs: Successfully corrected 7 bit errors per=
 subpage
>>> [   49.200140] mtd_nandbiterrs: Inserted biterror @ 2/6
>>> [   49.207182] mtd_nandbiterrs: rewrite page
>>> [   49.212895] mtd_nandbiterrs: read_page
>>> [   49.216671] mtd_nandbiterrs: Read reported 3 corrected bit errors
>>> [   49.219670] mtd_nandbiterrs: verify_page
>>> [   49.225872] mtd_nandbiterrs: Successfully corrected 8 bit errors per=
 subpage
>>> [   49.229827] mtd_nandbiterrs: Inserted biterror @ 2/5
>>> [   49.236871] mtd_nandbiterrs: rewrite page
>>> [   49.242629] mtd_nandbiterrs: read_page
>>> [   49.246348] mtd_nandbiterrs: error: read failed at 0x0
>>> [   49.249356] mtd_nandbiterrs: After 9 biterrors per subpage, read rep=
orted
>>> error -74
>>> [   49.257958] mtd_nandbiterrs: finished successfully.
>>> [   49.262029] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>> #
>>=20
>> This is not the intended behavior. The reporting is wrong and should
>> report an increasing number of bitflips instead of 1, 1, 1, 2, 2, 2, 2,
>> 3.
>>=20
>> With this behavior, wear levelling will not work correctly.
>>=20
>> This is not related to Gabor's changes, but I believe this should be
>> updated otherwise it does not make much sense to increase the strength.
>
> It still makes some sense. For example, the bootloader on my board uses 8=
 bits
> strength when it handles the NAND flash. Without supporting that, the ker=
nel
> can't read the data written by the bootloader and vice versa.
>
>> Gabor, can you look into it? Both patches look fine otherwise, thanks a
>> lot!
>
> I have checked it. According to the code, the driver reads the reported v=
alues
> from a hardware register.
>
> Here is the result of another test but i have added some debug code to the
> driver so the output contains the hardware register values:
>
>   # insmod mtd_nandbiterrs dev=3D0
>   [   64.791395]=20
>   [   64.791423] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>   [   64.791950] mtd_nandbiterrs: MTD device: 0
>   [   64.797592] mtd_nandbiterrs: MTD device size 268435456, eraseblock=
=3D131072, page=3D2048, oob=3D128
>   [   64.801779] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
>   [   64.810313] mtd_nandbiterrs: Using page=3D0, offset=3D0, eraseblock=
=3D0
>   [   64.820832] mtd_nandbiterrs: incremental biterrors test
>   [   64.822452] mtd_nandbiterrs: write_page
>   [   64.828511] mtd_nandbiterrs: rewrite page
>   [   64.832270] mtd_nandbiterrs: read_page
>   [   64.836184] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0200 erased_cw:00000002
>   [   64.839091] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   64.847364] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   64.855694] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   64.864020] qcom_snand 79b0000.spi: corrected:0 failed:0 bitflips:0
>   [   64.872349] mtd_nandbiterrs: verify_page
>   [   64.878598] mtd_nandbiterrs: Successfully corrected 0 bit errors per=
 subpage
>   [   64.882760] mtd_nandbiterrs: Inserted biterror @ 0/5
>   [   64.889793] mtd_nandbiterrs: rewrite page
>   [   64.895541] mtd_nandbiterrs: read_page
>   [   64.899228] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0201 erased_cw:00000002
>   [   64.902282] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   64.910549] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   64.918860] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   64.927206] qcom_snand 79b0000.spi: corrected:1 failed:0 bitflips:1
>   [   64.935552] mtd_nandbiterrs: Read reported 1 corrected bit errors
>   [   64.941789] mtd_nandbiterrs: verify_page
>   [   64.948043] mtd_nandbiterrs: Successfully corrected 1 bit errors per=
 subpage
>   [   64.952042] mtd_nandbiterrs: Inserted biterror @ 0/2
>   [   64.959048] mtd_nandbiterrs: rewrite page
>   [   64.964815] mtd_nandbiterrs: read_page
>   [   64.968490] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0201 erased_cw:00000002
>   [   64.971586] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   64.979814] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   64.988131] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   64.996481] qcom_snand 79b0000.spi: corrected:1 failed:0 bitflips:1
>   [   65.004810] mtd_nandbiterrs: Read reported 1 corrected bit errors
>   [   65.011059] mtd_nandbiterrs: verify_page
>   [   65.017313] mtd_nandbiterrs: Successfully corrected 2 bit errors per=
 subpage
>   [   65.021307] mtd_nandbiterrs: Inserted biterror @ 0/0
>   [   65.028319] mtd_nandbiterrs: rewrite page
>   [   65.034131] mtd_nandbiterrs: read_page
>   [   65.037862] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0201 erased_cw:00000002
>   [   65.040844] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.049069] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.057418] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.065763] qcom_snand 79b0000.spi: corrected:1 failed:0 bitflips:1
>   [   65.074082] mtd_nandbiterrs: Read reported 1 corrected bit errors
>   [   65.080341] mtd_nandbiterrs: verify_page
>   [   65.086584] mtd_nandbiterrs: Successfully corrected 3 bit errors per=
 subpage
>   [   65.090574] mtd_nandbiterrs: Inserted biterror @ 1/7
>   [   65.097589] mtd_nandbiterrs: rewrite page
>   [   65.103374] mtd_nandbiterrs: read_page
>   [   65.107030] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0202 erased_cw:00000002
>   [   65.110120] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.118340] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.126689] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.135032] qcom_snand 79b0000.spi: corrected:2 failed:0 bitflips:2
>   [   65.143357] mtd_nandbiterrs: Read reported 2 corrected bit errors
>   [   65.149611] mtd_nandbiterrs: verify_page
>   [   65.155855] mtd_nandbiterrs: Successfully corrected 4 bit errors per=
 subpage
>   [   65.159844] mtd_nandbiterrs: Inserted biterror @ 1/5
>   [   65.166860] mtd_nandbiterrs: rewrite page
>   [   65.172645] mtd_nandbiterrs: read_page
>   [   65.176301] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0202 erased_cw:00000002
>   [   65.179389] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.187611] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.195961] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.204289] qcom_snand 79b0000.spi: corrected:2 failed:0 bitflips:2
>   [   65.212623] mtd_nandbiterrs: Read reported 2 corrected bit errors
>   [   65.218858] mtd_nandbiterrs: verify_page
>   [   65.225139] mtd_nandbiterrs: Successfully corrected 5 bit errors per=
 subpage
>   [   65.229102] mtd_nandbiterrs: Inserted biterror @ 1/2
>   [   65.236147] mtd_nandbiterrs: rewrite page
>   [   65.241899] mtd_nandbiterrs: read_page
>   [   65.245572] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0202 erased_cw:00000002
>   [   65.248635] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.256902] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.265234] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.273561] qcom_snand 79b0000.spi: corrected:2 failed:0 bitflips:2
>   [   65.281895] mtd_nandbiterrs: Read reported 2 corrected bit errors
>   [   65.288129] mtd_nandbiterrs: verify_page
>   [   65.294408] mtd_nandbiterrs: Successfully corrected 6 bit errors per=
 subpage
>   [   65.298373] mtd_nandbiterrs: Inserted biterror @ 1/0
>   [   65.305413] mtd_nandbiterrs: rewrite page
>   [   65.311170] mtd_nandbiterrs: read_page
>   [   65.314843] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0202 erased_cw:00000002
>   [   65.317906] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.326170] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.334501] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.342833] qcom_snand 79b0000.spi: corrected:2 failed:0 bitflips:2
>   [   65.351164] mtd_nandbiterrs: Read reported 2 corrected bit errors
>   [   65.357399] mtd_nandbiterrs: verify_page
>   [   65.363680] mtd_nandbiterrs: Successfully corrected 7 bit errors per=
 subpage
>   [   65.367643] mtd_nandbiterrs: Inserted biterror @ 2/6
>   [   65.374684] mtd_nandbiterrs: rewrite page
>   [   65.380445] mtd_nandbiterrs: read_page
>   [   65.384112] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0203 erased_cw:00000002
>   [   65.387177] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.395445] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.403769] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.412103] qcom_snand 79b0000.spi: corrected:3 failed:0 bitflips:3
>   [   65.420436] mtd_nandbiterrs: Read reported 3 corrected bit errors
>   [   65.426671] mtd_nandbiterrs: verify_page
>   [   65.432950] mtd_nandbiterrs: Successfully corrected 8 bit errors per=
 subpage
>   [   65.436915] mtd_nandbiterrs: Inserted biterror @ 2/5
>   [   65.443958] mtd_nandbiterrs: rewrite page
>   [   65.449719] mtd_nandbiterrs: read_page
>   [   65.453386] qcom_snand 79b0000.spi: cw[0] flash:00003030 buffer:00ff=
0301 erased_cw:00000002
>   [   65.456448] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.464715] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.473041] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   65.481374] qcom_snand 79b0000.spi: corrected:0 failed:1 bitflips:3
>   [   65.489706] mtd_nandbiterrs: error: read failed at 0x0
>   [   65.495941] mtd_nandbiterrs: After 9 biterrors per subpage, read rep=
orted error -74
>   [   65.504609] mtd_nandbiterrs: finished successfully.
>   [   65.508700] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
>
> Basically, the driver reads the page as 4 codewords along with reading the
> register values after each. The reported values are coming from the low=20
> 5 bits of the 'buffer' values printed above. The layout of the register is
> barely documented in the driver, so the exact meaning of the bits is unkn=
own.
>
> Despite that, I had an idea, so I have changed the code in the nandbiterrs
> module to insert only single bit error into a given byte. By doing the te=
st
> with the modified module results in the following:
>
>   # insmod mtd_nandbiterrs dev=3D0
>   [   37.125416]=20
>   [   37.125444] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>   [   37.125970] mtd_nandbiterrs: MTD device: 0
>   [   37.131764] mtd_nandbiterrs: MTD device size 268435456, eraseblock=
=3D131072, page=3D2048, oob=3D128
>   [   37.135695] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
>   [   37.144314] mtd_nandbiterrs: Using page=3D0, offset=3D0, eraseblock=
=3D0
>   [   37.155047] mtd_nandbiterrs: incremental biterrors test
>   [   37.156481] mtd_nandbiterrs: write_page
>   [   37.162518] mtd_nandbiterrs: rewrite page
>   [   37.166298] mtd_nandbiterrs: read_page
>   [   37.170193] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.173111] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.181383] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.189708] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.198020] qcom_snand 79b0000.spi: corrected:0 failed:0 bitflips:0
>   [   37.206367] mtd_nandbiterrs: verify_page
>   [   37.212631] mtd_nandbiterrs: Successfully corrected 0 bit errors per=
 subpage
>   [   37.216768] mtd_nandbiterrs: Inserted biterror @ 1/7
>   [   37.223809] mtd_nandbiterrs: rewrite page
>   [   37.229569] mtd_nandbiterrs: read_page
>   [   37.233244] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0201 erased_cw:00000002
>   [   37.236301] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.244571] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.252896] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.261227] qcom_snand 79b0000.spi: corrected:1 failed:0 bitflips:1
>   [   37.269560] mtd_nandbiterrs: Read reported 1 corrected bit errors
>   [   37.275795] mtd_nandbiterrs: verify_page
>   [   37.282075] mtd_nandbiterrs: Successfully corrected 1 bit errors per=
 subpage
>   [   37.286039] mtd_nandbiterrs: Inserted biterror @ 3/7
>   [   37.293080] mtd_nandbiterrs: rewrite page
>   [   37.298877] mtd_nandbiterrs: read_page
>   [   37.302531] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0202 erased_cw:00000002
>   [   37.305572] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.313839] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.322169] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.330498] qcom_snand 79b0000.spi: corrected:2 failed:0 bitflips:2
>   [   37.338818] mtd_nandbiterrs: Read reported 2 corrected bit errors
>   [   37.345078] mtd_nandbiterrs: verify_page
>   [   37.351352] mtd_nandbiterrs: Successfully corrected 2 bit errors per=
 subpage
>   [   37.355310] mtd_nandbiterrs: Inserted biterror @ 5/7
>   [   37.362352] mtd_nandbiterrs: rewrite page
>   [   37.368094] mtd_nandbiterrs: read_page
>   [   37.371814] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0203 erased_cw:00000002
>   [   37.374843] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.383111] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.391437] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.399769] qcom_snand 79b0000.spi: corrected:3 failed:0 bitflips:3
>   [   37.408089] mtd_nandbiterrs: Read reported 3 corrected bit errors
>   [   37.414351] mtd_nandbiterrs: verify_page
>   [   37.420616] mtd_nandbiterrs: Successfully corrected 3 bit errors per=
 subpage
>   [   37.424581] mtd_nandbiterrs: Inserted biterror @ 7/7
>   [   37.431622] mtd_nandbiterrs: rewrite page
>   [   37.437419] mtd_nandbiterrs: read_page
>   [   37.441072] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0204 erased_cw:00000002
>   [   37.444114] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.452380] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.460708] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.469047] qcom_snand 79b0000.spi: corrected:4 failed:0 bitflips:4
>   [   37.477360] mtd_nandbiterrs: Read reported 4 corrected bit errors
>   [   37.483621] mtd_nandbiterrs: verify_page
>   [   37.489888] mtd_nandbiterrs: Successfully corrected 4 bit errors per=
 subpage
>   [   37.493852] mtd_nandbiterrs: Inserted biterror @ 8/7
>   [   37.500893] mtd_nandbiterrs: rewrite page
>   [   37.506636] mtd_nandbiterrs: read_page
>   [   37.510342] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0205 erased_cw:00000002
>   [   37.513385] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.521652] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.529978] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.538297] qcom_snand 79b0000.spi: corrected:5 failed:0 bitflips:5
>   [   37.546643] mtd_nandbiterrs: Read reported 5 corrected bit errors
>   [   37.552896] mtd_nandbiterrs: verify_page
>   [   37.559161] mtd_nandbiterrs: Successfully corrected 5 bit errors per=
 subpage
>   [   37.563123] mtd_nandbiterrs: Inserted biterror @ 10/7
>   [   37.570168] mtd_nandbiterrs: rewrite page
>   [   37.575956] mtd_nandbiterrs: read_page
>   [   37.579702] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0206 erased_cw:00000002
>   [   37.582743] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.591010] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.599354] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.607655] qcom_snand 79b0000.spi: corrected:6 failed:0 bitflips:6
>   [   37.616004] mtd_nandbiterrs: Read reported 6 corrected bit errors
>   [   37.622249] mtd_nandbiterrs: verify_page
>   [   37.628504] mtd_nandbiterrs: Successfully corrected 6 bit errors per=
 subpage
>   [   37.632497] mtd_nandbiterrs: Inserted biterror @ 12/7
>   [   37.639524] mtd_nandbiterrs: rewrite page
>   [   37.645353] mtd_nandbiterrs: read_page
>   [   37.649047] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0207 erased_cw:00000002
>   [   37.652100] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.660367] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.668679] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.677029] qcom_snand 79b0000.spi: corrected:7 failed:0 bitflips:7
>   [   37.685358] mtd_nandbiterrs: Read reported 7 corrected bit errors
>   [   37.691607] mtd_nandbiterrs: verify_page
>   [   37.697861] mtd_nandbiterrs: Successfully corrected 7 bit errors per=
 subpage
>   [   37.701852] mtd_nandbiterrs: Inserted biterror @ 14/7
>   [   37.708867] mtd_nandbiterrs: rewrite page
>   [   37.714683] mtd_nandbiterrs: read_page
>   [   37.718397] qcom_snand 79b0000.spi: cw[0] flash:00003020 buffer:00ff=
0208 erased_cw:00000002
>   [   37.721478] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.729718] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.738037] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.746433] qcom_snand 79b0000.spi: corrected:8 failed:0 bitflips:8
>   [   37.754719] mtd_nandbiterrs: Read reported 8 corrected bit errors
>   [   37.760972] mtd_nandbiterrs: verify_page
>   [   37.767218] mtd_nandbiterrs: Successfully corrected 8 bit errors per=
 subpage
>   [   37.771214] mtd_nandbiterrs: Inserted biterror @ 17/7
>   [   37.778225] mtd_nandbiterrs: rewrite page
>   [   37.784054] mtd_nandbiterrs: read_page
>   [   37.787754] qcom_snand 79b0000.spi: cw[0] flash:00003030 buffer:00ff=
0301 erased_cw:00000002
>   [   37.790836] qcom_snand 79b0000.spi: cw[1] flash:00002020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.799076] qcom_snand 79b0000.spi: cw[2] flash:00001020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.807395] qcom_snand 79b0000.spi: cw[3] flash:00000020 buffer:00ff=
0200 erased_cw:00000002
>   [   37.815743] qcom_snand 79b0000.spi: corrected:0 failed:1 bitflips:8
>   [   37.824073] mtd_nandbiterrs: error: read failed at 0x0
>   [   37.830321] mtd_nandbiterrs: After 9 biterrors per subpage, read rep=
orted error -74
>   [   37.838993] mtd_nandbiterrs: finished successfully.
>   [   37.843068] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> Interestingly enough, it reports the correct number of bit errors now.
> For me it seems, that the hardware reports the number of the corrected
> *bytes* instead of the corrected *bits*.

I doubt that, nobody counts bytes of errors.

You results are surprising. I initially though in favour of a software
bug, but then it looks even weirder than that. Alam?

Thanks,
Miqu=C3=A8l

