Return-Path: <linux-spi+bounces-12494-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCF8D3B3B1
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 18:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3462300161D
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 17:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF34232470A;
	Mon, 19 Jan 2026 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="cP88G7fa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFA1F4615
	for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842953; cv=none; b=U5IIWmnuOfQdfbxukswFZWY1RVK7Z982X9KSDQ8KbdxBBzwfMILzWBgH2H7zmOsNyT6BaJi7BS+7tkXooc9lQZ/HEf1xHf/+zLAX8srGJDwpkyJhpTB0fP9ViWM3k7k4i/zvGu/Rc1Z6J2s2At52rvTHnW2a76qp10ByQg928Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842953; c=relaxed/simple;
	bh=ST6jN/346GRbnIVq/GL4DxT/AqAUaeF6umCAVbE0YxQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KqeZEt/CSl79cRqxoN3yGjAhl1PKrrNvZAw1pFIpfarv87t6YyrUrt8Hb68Pq/AyKbZixUwoSbNlFTjaUbhAiZkrTVVBF0JiiZP5yqKYnr42OfjIOdA0p2adx2stl81lx0iw4FPP6NlfmIrciJJPH8cPyRs0WeTvUywTp+jbWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=cP88G7fa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a09757004cso40385885ad.3
        for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 09:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768842952; x=1769447752; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKh5VhKWJDfvZ+/kW792nGDNCXhsqOgN8MgniXfKmm4=;
        b=cP88G7faiR50w/wFqq0HMGDzZ2Ho5paWqdd4Qc/aEkWIqp7BsRQWHSTCRGLs9VEa3E
         svaErMXzjaB4lUtl6nfnDeviK6kOXL1gFzAwmG7yiMpuO3Cj0NWLiarXSQDdqPZ2FWDB
         m6CmP4TjN0KPJVL6WJZfjz4eLZhxEbrVO6Qam071vMXoO4eBKbJPapZeCX4L9RR/dOod
         j3nw4F6a68Vts/IBcx8gBl+YZn3ng3zAkG51XEmiCHwdYTVgeq91JcoRTEAx9ZPUDfeo
         IkETVhL7pr6reX3h+ZXdNs6KB83aJPg1LiRhJqzrpg+f69x0hAWnwAxritDaeAKN9UFI
         Rl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842952; x=1769447752;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKh5VhKWJDfvZ+/kW792nGDNCXhsqOgN8MgniXfKmm4=;
        b=CWG3Z7t1osVnE0atgfD+qbn+l188vejXNewHMbcVHjShyouLYJKDqEZ+5ZNaLyUaVr
         hZM2nxkYfW9jeRQPIX5GVh/X330Rryov+L9w3PUtHvQOM8YxT7YzMnZKfLbZd7I0GytI
         4SrPb7AES3eUL4qAhLjEw7MwB3FbifEmET/xstnJhPeubgfczYpu6gRSacGMoh/CQSOV
         mKb7aPhj/kzbMOBGH4FmBneEBrad0qrEJB+7BYDVxK+7ppMaU67no2UwdKHhMOWq6yW6
         aIqHVZcOXeO5AUrcilV5P/cFYlgYvAKTvD7PhIoNwTiccoUlmMKoNKZrVUXp1v9SPr7L
         XXCA==
X-Forwarded-Encrypted: i=1; AJvYcCXQTsN7FvrCcNUNtdGqkbvf67sdCOsuBHw8uIWHV7xzqAVDLlrLeJwBqbdjdQiEdZPhdYTkFhfZ41I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYgXV2qw6DROx6JyEf1u/O5FydTZj9DmMY4k8GiXFmyXcypoRL
	9aJZfEbXWiuFn+63GNKrn6auH0xcBDjUvV2p3I3w1i7NVvegYFNlphi8Pk2MQVhxqog=
X-Gm-Gg: AZuq6aI4EQddVG1vBqT5HGVUXm4QJH4OJuDIVKHGy2vKuTjW6JWDy+v5J8mD39pbWx4
	jFbzEuQzUI94JTQ79pJttE0fSiNu9YIdy9O1CkGPO/75ITfeBK63EQvLzEmuvmKG7Qsgn1M3guq
	LFL4+akGBQFsPOvdHARG4WqxnkEhmLMYuP5HAOWUUjUWRpVubb2j0xGovkwjfFwFf3QYPzg9yjp
	ghnRuMwSEAiMaSoN6sLAAxjm18Wuc3FuZ4D9uaYhXuc9FnE+IMOFsRYOplCN5ORbjjk22JHwbBa
	k+uhzIiOOc0bAn8ODi0Kp4Nwy1y9NbL0JVxqsFn646CzX/14Xm+TXOB4DunObYvM3F+hyRcQbwl
	xFvXVrvmyCzAI8lGnUuNje76MDcKqdhNjCFeSHrv/BXUb+OtL3u2hu3kWy/7N+k1ctle6dIrH93
	ZQPbK5EVVpsSZAWwS/D2R0oGc736+jRi8C65D1aCF41ZEiIvrLXelE5hoKOrLZGXMnAZ4FGYo=
X-Received: by 2002:a17:903:24e:b0:2a1:4c31:335 with SMTP id d9443c01a7336-2a71753513fmr115578615ad.26.1768842951841;
        Mon, 19 Jan 2026 09:15:51 -0800 (PST)
Received: from smtpclient.apple (c-24-16-26-157.hsd1.wa.comcast.net. [24.16.26.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190aa334sm46857445ad.5.2026.01.19.09.15.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 09:15:51 -0800 (PST)
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
In-Reply-To: <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
Date: Mon, 19 Jan 2026 09:15:40 -0800
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <05D2CC15-DD6B-40F0-BFF0-3264D4FF96ED@nexthop.ai>
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
 <8436e914-429f-40b9-8e6f-ec3b02702cad@sirena.org.uk>
 <69F83558-4675-4FC2-8656-BC6E3481AD65@nexthop.ai>
 <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 19, 2026, at 8:50=E2=80=AFAM, Mark Brown <broonie@kernel.org> =
wrote:
>=20
> On Mon, Jan 19, 2026 at 08:47:17AM -0800, Abdurrahman Hussain wrote:
>>> On Jan 19, 2026, at 8:32=E2=80=AFAM, Mark Brown <broonie@kernel.org> =
wrote:
>>> On Mon, Jan 19, 2026 at 07:06:24AM +0000, Abdurrahman Hussain via B4 =
Relay wrote:
>=20
>>>> - of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
>>>> -  &num_cs);
>>>> - ret =3D of_property_read_u32(pdev->dev.of_node,
>>>> -   "xlnx,num-transfer-bits",
>>>> -   &bits_per_word);
>>>> + device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
>>>> + &num_cs);
>>>> + ret =3D device_property_read_u32(&pdev->dev,
>>>> +       "xlnx,num-transfer-bits",
>>>> +       &bits_per_word);
>=20
>>> Are these bindings appropraite for ACPI systems?
>=20
>> Yes, the Xilinx IP blocks are memory mapped and work exactly the same =
on ACPI as they do on DT.
>=20
> That does not answer the question at all.  Is it appropriate to
> configure an ACPI system in this way?

I am not sure I understood your question. What do you mean by =
=E2=80=9Cappropriate=E2=80=9D?
This is following the same guidelines as outlined in=20
=
https://www.kernel.org/doc/html/v6.7/firmware-guide/acpi/enumeration.html


