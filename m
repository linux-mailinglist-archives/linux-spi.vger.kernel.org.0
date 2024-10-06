Return-Path: <linux-spi+bounces-5113-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AA7991F41
	for <lists+linux-spi@lfdr.de>; Sun,  6 Oct 2024 17:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521FD1C21145
	for <lists+linux-spi@lfdr.de>; Sun,  6 Oct 2024 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D3D13D889;
	Sun,  6 Oct 2024 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="IT55S9/z"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F12146586;
	Sun,  6 Oct 2024 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728227527; cv=none; b=NAEUsqZLraAYioQkGLzm/p0wW8KoJRyI5TgzLPWTWW1YeD/jtfrmoTISJxuQIOT2oJOyVyFD7S3L9xTZwktZHi2xdKdx5r9E2kcluMxyYFw9GENncNb3Rq0iingKzrCNrIoFZapxSoAodZG4rbrfhIvpUq56+04kWWAA+mzyMqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728227527; c=relaxed/simple;
	bh=AiUhZYra/S3TwkrQaWv+4k/n6y9o56HzZ1mWTaA3EEo=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=Kc0b23mbGkm6N7rURViKd1RmzuTKFUZDfECuvVxU0exIfVy1Kwhah5B/UB1PjJy1ZaDuFqCuFD/nV63Fw4n1uS5XvclViE7kIwZz2Mt6u//3gDPyB8Ek3DOUsM3kjICN/gjI808rxY+r4QNB9N4BzKK8Th0Y+Q4DFREm8Y8C7xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=IT55S9/z; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1728227502; x=1728832302; i=frank-w@public-files.de;
	bh=AiUhZYra/S3TwkrQaWv+4k/n6y9o56HzZ1mWTaA3EEo=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IT55S9/zb6+UVYGRv5GNvFhzx8sz4iXDSJdInl2Xq0yCDvJVE0fa55tM7QYRgF0G
	 sQ38OEVBi7iJedov/PJS+7UvZ7g0q3S368wHAq/Z6EcZsiryLR36r4QMjM9OZkqQd
	 qqvOM9Oo1mQvAX7yruCmQF/V8eB5+ov5Y3UncVbleJ4jNL7LyF7hMfAFJHXPrPxNP
	 AHS7OqcrE9vgDYOfeCvLARf7QcDhNn9ErkM+/IGF8GGFZuZOxWPOPaQ3tciPPZQ45
	 RAB/IVZuqsYvytmXOPulnrBhCsETnhjLPk4Kpc8ogcyIA4den8L75JNse4uUMzUZm
	 B8L2it+tx7tI2aKobA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.153.101] ([217.61.153.101]) by web-mail.gmx.net
 (3c-app-gmx-bs41.server.lan [172.19.170.93]) (via HTTP); Sun, 6 Oct 2024
 17:11:42 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-5ceed296-8a65-4892-b449-6f832a978d69-1728227502700@3c-app-gmx-bs41>
From: Frank Wunderlich <frank-w@public-files.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank Wunderlich <linux@fw-web.de>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Leilk
 Liu <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 daniel@makrotopia.org, john@phrozen.org, eladwf@gmail.com,
 ansuelsmth@gmail.com
Subject: Aw: Re: [PATCH v1] dt-bindings: spi: add compatibles for mt7988
Content-Type: text/plain; charset=UTF-8
Date: Sun, 6 Oct 2024 17:11:42 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <kmzl5zmqqudoq2jcdacfsbwq3axdvcml4m5kw5oqqo2hj6iiuq@xzeg6penuic3>
References: <20241006102740.17948-1-linux@fw-web.de>
 <kmzl5zmqqudoq2jcdacfsbwq3axdvcml4m5kw5oqqo2hj6iiuq@xzeg6penuic3>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Btf22OQQiWHbAxP7CwpcejS6hY9mQkc8eIiKzvNtfMmCAlN3qqALUu45gnV+SHw4ffNOm
 vSi1wjtYZBy1hSY9rNpHbU6+Ye7QfBx3k4TmOufADwfaZwZhI/yO6oVjngQPo2YzptkWh/MZupkp
 QPiWcKXAMoQnStXeX8m/Dh41uvECwPHspqdn6TE66cCAm7Lly6UMyiosIpVTqF90TLsz00ojI9qm
 BeaNtuPimSMpdLQiQ/aY+85k3qrfJg/kOZzaPq5dCJydhL6seQoBsSL8cYNbl4bNbTIKmshZ69t0
 rw=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O7onKpdDbCQ=;P1dfCcTaf7pXMv38K6Mviv5Zqig
 vo0g/fwJLt9POd1LtSUXZAaYt7sg/LAtgKdTCcgOMwo3X5W8PipUr/JMqJjn8fiOlTbynrUv0
 PYcKwCn3BtdkKoMnVuTz9GKb3belALvCc5uTVVCSv+jSOOXt/+GNWXinC8XmZtjqq1YQaUmrx
 DrdgcHKPLRGkMxDtxwI+AUNjVekHXY5ANDIU6fn3D3NzSGdaSDHxHnY6Fsq0PCDOOCJxCc6B6
 dhX3jBTaDuTNG6huH1BD6ayqRd3nUdFrRMfaashBy3L8zBuzQhWNogQ3jUNZl8GwsGR/++kW0
 TeyBU73mi/H2lYu6pYYWDtnQkhwEppf1UzfQ4u9n8kf/fx7a2U9RoO71uy1nhwAAcjjkRBiaX
 o5sVnWgLyADrobn+L20WmvF2IJ9p03535zf9cYDYdbbHjYq4hFO/NlmbECFz9dr0F2TOQGG2n
 EpxVxHW+P7q2THuQIRyWiUedArJL/ZhSAmvFzKr5Mo70AfJv+olAkwHH15mLTVTmvwCl2cKKX
 8eWC4t0XVkSuCE1wCaD/AxyxIRFqvvTp8DW08oydRpdyaaYumKTd1sHco6cevpnqovsmmZyyl
 96hMmUQywTNZU13hFlLttrzX1xYYWajzDfJAs5wLNDWRHzzgq8vu0KxHVevcaH/M7XDAiEcXK
 TBrzmhTwOIYRxLTX89yaXoHk78MEiY4VfudKOmkG/g==
Content-Transfer-Encoding: quoted-printable

Hi

> Gesendet: Sonntag, 06. Oktober 2024 um 14:48 Uhr
> Von: "Krzysztof Kozlowski" <krzk@kernel.org>
> Betreff: Re: [PATCH v1] dt-bindings: spi: add compatibles for mt7988
>
> On Sun, Oct 06, 2024 at 12:27:39PM +0200, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > MT7988 has 2 different spi controllers. Add mediatek,ipm-spi-single
> > and mediatek,ipm-spi-quad compatibles.
>
> Why generic compatibles?
>
> These are supposed to be SoC-specific.

currently i used the compatibles used in SDK, but got info now, that there=
 is some more discussion needed with mtk.

> Best regards,
> Krzysztof
>
>

