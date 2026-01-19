Return-Path: <linux-spi+bounces-12492-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA96D3B411
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 18:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A11CA302E31C
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777E332B9A9;
	Mon, 19 Jan 2026 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="CqxDbK0J"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348330AAAE
	for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841251; cv=none; b=DxB073s2ZMqr9RHGWxITWdjNDsN+ZN9WXrLw2gyWba47woH092g7U2llVbZ1dS43iLDBVpd+P0rhE1BYgNqtObcUoF+7sctffxPld2ccbNSUBJ/8FSd+EuVC6eoY/l6uU6cJQYYO0oc482QO10spTxVkWAy+wxOsxH6hoys5XEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841251; c=relaxed/simple;
	bh=kkRxZrcdNFSB+trECzPFQy2pB0PwFJJ0L0xcgbLYQkE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XBSFiPRnZpo3zyT3tiR4Bd/9tl1mhf1Jvbbg2YTlcOyST9K60mk3/6+XdkB2qrqP93JxFqRm3vlnP0Pk+Q3H9P9Y7wDsXPEzzug/4/Hxi3ew3xB9xZ8+42Xz8YwCMzIoj861ub0mFFibL4FMjhEz+QutlXR+gxz8O6IgdFQQ//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=CqxDbK0J; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a12ebe4b74so42993035ad.0
        for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 08:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768841249; x=1769446049; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb7EXkVeeyYYPDZluNCIirhlK7FHyduzjPpO6/F/48I=;
        b=CqxDbK0JUm3s73iraSLePWJrWN1GVkAwvEIQ26swJhbFJceUOPq1Vlrme0vxtN/H9Q
         /W7a4cb+1Nj9KGlmJrwlrT0zWtoM1TTDbO0VKCQvp+vVJsckDsl/o1BfKiYSY5l7zx5q
         t/X6VOTmJZmc62BiyX8/pvS/ICylwa+XPU2nnKa6uyiveSf7Ukmb2VNdsVw9GBhCuyMY
         EgtoDhjyITGvIXFvGHlzzi+DPPZ3NoM2zl24sVgTbBjLPeHM+cW27yQ1qLVRLOD+Ic2d
         7eg2mVFIcOXXsuxI2ujUy6n2vR2m0+JNPcpOdusjVihiv7dUOFXVt3OhYvX0XWwsEd7t
         EcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841249; x=1769446049;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mb7EXkVeeyYYPDZluNCIirhlK7FHyduzjPpO6/F/48I=;
        b=ucWntOqOi6pV3nl+ksI3xgacJE+/m3aPVXCDTh2vUWfL8hfYvriyq8hLafjDbXM9xL
         LSskVRnNHtHRv2RKXoOj9sf1TAvbX34YfpWgnt3XuwzSMnAbkIiPAgvbrPrE3WSI5Re6
         6tMWVrNUQp1r1/38MSR0a5/SdI8lOKlaetXIlaqH35P+Cg3z4dm3QNOKwnr0YQhAYseM
         ab2Czxwdfrf9kKkq+sz6CG6RVQLQAZQ7Qp16LKFWZYPTVFQrSdSN1zh92Nnc9vPG2oqY
         kfO5pMe5/J69dwbp10uSLAbXw4h+Nv7D5hhDOvEB8tAryFT2Ug9Ov52P5eZYYEOnSt7/
         oMpA==
X-Forwarded-Encrypted: i=1; AJvYcCWlWPw+W+eRol+GLA2uhLpCl1MhYqjaHjxneqR4/8Ly+ywcxHCuB89Kc+2aMZ/MuX3OaELbOpQFeqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYkIGm8b5PdC0n24bqdnzXLQ5bebhg00DWm80kbL6eButfVTNg
	tDmBcXHyrpCVbpMfYCT6+8eNAGwOm4ynNEbRyY1sujaM+xI1IC6YYkLCYFb28NtBGt8=
X-Gm-Gg: AZuq6aIYxMe9IFK+Y7yqbd0gOKDN3WlPXTGQmb9K+wWSjVirVOCYccIGqb4902TItgn
	C0jkkgu5hld5xGausafCbf3amph5ogBD8xAvR+V2PXKrFl6MIewDJkdYlg5q2508UkMuTxQZ2uu
	kCa5jMZxioADuBJ6/1P7PKvObICPJIwz/JdNDMn9i62BxPFNHLgdXJJkYrQLie0XAYXuuET0G1e
	PXe4RaIJBh+NKAHjHTR0XwX5+M8defQB/693aplSYPn/10B4Q3A/ljuBkreLpy/EZEODTCXmq2J
	T/c+H+aNjbvMUTs8GX11OxcXr33QigQNKlP5+nlrZ3NqZqRZSmD86hJxSU1Q06Y+8mqjigcw9nu
	WO4MgbHLdUYbsaja9vEDA00aJTZPCTOpdjEly4DxJEQrJFHKpGh+gUEuCMJZoxvzNtuKWRo9gLi
	2yFOOriKtOsEI/gpNaQ3YLnZyqI+zqQTH9iuWVqqdDY1Sjbaf43qKovAw66qqK5Mysxg==
X-Received: by 2002:a17:903:138a:b0:29e:fd60:2cf9 with SMTP id d9443c01a7336-2a7177e0b55mr115393845ad.54.1768841249474;
        Mon, 19 Jan 2026 08:47:29 -0800 (PST)
Received: from smtpclient.apple (c-24-16-26-157.hsd1.wa.comcast.net. [24.16.26.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7194164dfsm96897605ad.88.2026.01.19.08.47.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 08:47:29 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <8436e914-429f-40b9-8e6f-ec3b02702cad@sirena.org.uk>
Date: Mon, 19 Jan 2026 08:47:17 -0800
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <69F83558-4675-4FC2-8656-BC6E3481AD65@nexthop.ai>
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
 <8436e914-429f-40b9-8e6f-ec3b02702cad@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 19, 2026, at 8:32=E2=80=AFAM, Mark Brown <broonie@kernel.org> =
wrote:
>=20
> On Mon, Jan 19, 2026 at 07:06:24AM +0000, Abdurrahman Hussain via B4 =
Relay wrote:
>=20
>> -		of_property_read_u32(pdev->dev.of_node, =
"xlnx,num-ss-bits",
>> -					  &num_cs);
>> -		ret =3D of_property_read_u32(pdev->dev.of_node,
>> -					   "xlnx,num-transfer-bits",
>> -					   &bits_per_word);
>> +		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
>> +					 &num_cs);
>> +		ret =3D device_property_read_u32(&pdev->dev,
>> +					       "xlnx,num-transfer-bits",
>> +					       &bits_per_word);
>=20
> Are these bindings appropraite for ACPI systems?

Yes, the Xilinx IP blocks are memory mapped and work exactly the same on =
ACPI as they do on DT.=

