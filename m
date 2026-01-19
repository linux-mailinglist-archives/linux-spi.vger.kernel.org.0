Return-Path: <linux-spi+bounces-12496-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7BBD3B4F3
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 18:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23FDA301054B
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 17:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCB8328B63;
	Mon, 19 Jan 2026 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="JuVrS036"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EED3009D4
	for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844844; cv=none; b=Id4LYrg/TbniIKhRvzBzNtxgomkJI0DnWnyuzTeJJL5Dcveekl6+X31d3cozhUl1MOdt6HiwzSGKZQJ1997bNMYWKZZA7CsrP2booTaaogbWCmGMcBlKGvA3N4UJgRZUTZtlNIVCTjY3zJFybFVD0YlGkHUAU24d5hwANWNwTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844844; c=relaxed/simple;
	bh=UXz1GXuN6+Lb+cRGNam/+7JreOgouX0gxJ7F0pP8Rdk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mQFZMHX5xJ0zkJdOkiuIa9jodCWxH5j/rrJFIKgcdeRU73TeeMp9JldIABMXFBRDaVqBgEe6hLqoKc9IDlx9FVDQGKJtC8B3a28PtZp30s5M9ZF+6v8WrY/MPEEc1Py5qgYbzZl/5egssqtnPWTCQTMLT1QRvJsDFSzv0XMQewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=JuVrS036; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a1388cdac3so31311535ad.0
        for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768844842; x=1769449642; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9vmCqAtGysKfxxBfNQvQzZYtQZW3BMU6u0QIwzm6DI=;
        b=JuVrS036VJO+Gtkmz9lIv9i2WnkrH4pHhBVVENM7PxguhmnLEPYUvUPmRF4J0N8xqk
         yBk6h60AIlm27romoyfQAgHX80o2ie3Pgaud0d4O40cXzS6RzsnknCVNlUZIm/Q3rtau
         30X9R+KH8J/iwDsip2qUnv01jB0ZmvGiMrnP6LsXjpslszHF5itoqNwKLNFUassZdy9t
         /xXk5bK5yD74Wc3Eu2EAtF5Po8K6+Ui1K73Kl0N+Jmbv/I3IZ0BLv3mh9KnU3+0X1ILV
         Vr+NG9X9j0JIONwF0h68DjyQ7kTUE1eisBPQA5ThXMqqvKgeSa2ZeXUL3rEDF+qi8sh1
         SgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768844842; x=1769449642;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9vmCqAtGysKfxxBfNQvQzZYtQZW3BMU6u0QIwzm6DI=;
        b=sfkKQffCJ4QTkvwozLrlbb3tN+inVk0hPL36EqnSV5egCg3CkHyfp7TTOvntwEErwe
         wlmp4CeDl8/px3FnS5ogOd9lC5mmnBA8oGtG3vBTnWWdYRUdYYVUTXNZnGQ3XCChYnMM
         m9rPGeZghEw54HexqGS0qUfwgZOhItAzzH/U2PimWOnR4YuQkXZ/AegcD0iKpbgwoCB/
         3FHoHcH12liE4/wQ0nKR++x0K5GCls/MMujJ00bhPbTl2dhlTZB5izDjl5y/LG2UQby8
         h1KuZBD//bB1Fw7Mun/d6UarJ4tTUXJt4sTsUNJXgEQtnRmhkvt+6/ujSpeHNwkTmBJ8
         M/fA==
X-Forwarded-Encrypted: i=1; AJvYcCVkrkkKa0H0BEcBgSH9lDGYnRw+9J5Q/j3qf8RspCUEPsYFQnTm7bxHT4ckCzQ/VlATd7nyxIZAn+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgEdqS8CWiJIfNBdF9raB/F62DmVTx/+OmLG6XKRtq6vLzQ0d+
	AsH8P0ocN3VajmoMBUKNPC0eKYACIR/IQftbS3NqlhsugLfCMyd5la+WcPo4QZTmbBI=
X-Gm-Gg: AZuq6aItiphM/9Q81d8b1RRiHo/9XTUsoYjIfXt4APH1n/3YQ8SJC/JuZ9RnBMXLcJo
	oy5VPSJrpszmH3nn2fZeq0vyXkFw/NEdoKZ1nTyOFr0dJ7H5CM/4p1C2zB3so69zE5AikjS3Xl5
	rV57AedH+pB6l2vJ5bV69MHxHgoZkiSMI3WdUJ1NDDFU4U6NXyAzY2ePWiLbEoRiPprhJ6U6NoO
	Uxy+RhDskanHYGhctjSkU508GJGRxNCwkCVQryQpgfqxKP0Q+FEvgPvIi5Vpw8Gpo90Ty5CUtac
	1pFgnlgRsOmHGNZP2DPk0hrfUB1gBaoFPjWtKbizUfEaNQZ+SwG+tyGpEib/KyBnCqBv1whHBry
	XPK5TGwykzAOz0OaBCQFMaLq5o6ofyU3XY+rONPPTTCl1nbz8QeJFu9VruL5GD5Db1pdQcxebfw
	4hwJXmtWvj39tqMPGp79LASyOJjYKOTecNCFmwzxeq+jHsoWZFHIO9/fcCDsEjfTBbj6UuqZQ=
X-Received: by 2002:a17:902:cf07:b0:2a0:ad09:750b with SMTP id d9443c01a7336-2a7174efc3fmr85950055ad.9.1768844842261;
        Mon, 19 Jan 2026 09:47:22 -0800 (PST)
Received: from smtpclient.apple (c-24-16-26-157.hsd1.wa.comcast.net. [24.16.26.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dca71sm98315145ad.48.2026.01.19.09.47.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 09:47:21 -0800 (PST)
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
In-Reply-To: <b1b79de0-a078-486d-b3e9-96899354407c@sirena.org.uk>
Date: Mon, 19 Jan 2026 09:47:11 -0800
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D1B59A7-6E57-4C8C-AA95-EA7AA115264F@nexthop.ai>
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
 <8436e914-429f-40b9-8e6f-ec3b02702cad@sirena.org.uk>
 <69F83558-4675-4FC2-8656-BC6E3481AD65@nexthop.ai>
 <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
 <05D2CC15-DD6B-40F0-BFF0-3264D4FF96ED@nexthop.ai>
 <b1b79de0-a078-486d-b3e9-96899354407c@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 19, 2026, at 9:32=E2=80=AFAM, Mark Brown <broonie@kernel.org> =
wrote:
>=20
> On Mon, Jan 19, 2026 at 09:15:40AM -0800, Abdurrahman Hussain wrote:
>>> On Jan 19, 2026, at 8:50=E2=80=AFAM, Mark Brown <broonie@kernel.org> =
wrote:
>>> On Mon, Jan 19, 2026 at 08:47:17AM -0800, Abdurrahman Hussain wrote:
>=20
>>>>> Are these bindings appropraite for ACPI systems?
>=20
>>>> Yes, the Xilinx IP blocks are memory mapped and work exactly the =
same on ACPI as they do on DT.
>=20
>>> That does not answer the question at all.  Is it appropriate to
>>> configure an ACPI system in this way?
>=20
>> I am not sure I understood your question. What do you mean by =
=E2=80=9Cappropriate=E2=80=9D?
>> This is following the same guidelines as outlined in=20
>> =
https://www.kernel.org/doc/html/v6.7/firmware-guide/acpi/enumeration.html
>=20
> You are just bindly making the DT properties available as _DSD
> properties on ACPI systems, ACPI is a completely different firmware
> interface with it's own idioms.  Does this interface make any sense on
> ACPI?


=46rom the above link:

"The special DT namespace link device ID, PRP0001, provides a means to =
use the existing DT-compatible device identification in ACPI=E2=80=A6"

The following is an excerpt from=20
=
https://www.kernel.org/doc/html/v6.7/firmware-guide/acpi/DSD-properties-ru=
les.html

The _DSD (Device Specific Data) configuration object, introduced in ACPI =
5.1, allows any type of device configuration data to be provided via the =
ACPI namespace. In principle, the format of the data may be arbitrary, =
but it has to be identified by a UUID which must be recognized by the =
driver processing the _DSD output. However, there are generic UUIDs =
defined for _DSD recognized by the ACPI subsystem in the Linux kernel =
which automatically processes the data packages associated with them and =
makes those data available to device drivers as "device properties=E2=80=9D=
.

The two settings are just configuration data for the spi-xilinx driver. =
By switching to generic device_property_ APIs we can re-use the same =
driver on ACPI based systems where the properties are passed as _DSD.

Is this not appropriate?

Regards,
Abdurrahman


