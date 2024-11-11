Return-Path: <linux-spi+bounces-5683-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 846049C485B
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 22:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49098283C4C
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 21:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49701BCA02;
	Mon, 11 Nov 2024 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="JakcHvMD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D61AA7AF;
	Mon, 11 Nov 2024 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361302; cv=none; b=E0O14foaW9wIAhQdIS4zGFgkKy3/+yDzhvZ3goSrzslN4RwnqTmJ29b/MdF44kPSbVYFs2QQZIA6cMW33rQB39a7SvzZx2CQvzXUpTZfbCT3KFbi7F6fgUPLdU654MuC65pYF24YeplVWqZBtPHFAda/kse9QU/vB4NwZ6j1cEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361302; c=relaxed/simple;
	bh=rAnzzK5zdRKn2L0gzXe9C5T7wps3+4L97bJig/V80l4=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=HWbMSIm/5XMxJvz1n8qrCQl7gCA1nA5XJzNpuiE5NzdGOeflpwfmm/UKoyfvl79zBOfQhgKA4acalBkouMsSwRFJETRQHaHY6b78CskZ4XWB17Df41yWOS+foGxRRdR96onfPhLJyD8IEB4+WutoVBsf3ZfJql5Du16W5NgTLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=JakcHvMD; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1731361279; x=1731966079; i=frank-w@public-files.de;
	bh=6aJ7+7tAZ00QWBqGIx3TLXHhs8RBVJf18eC8WQggc1I=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JakcHvMDEcpFlELbXSTKoXlcb5SwyEHL0MxwTh+Z/5lArev21g99vCVHIKJVKack
	 wVGZNxyhco+frD3tEdR/Tb27phfJjAL/lOjK2a3R0UTOgz1m9Tqc1l3Gu7lm6fbK9
	 KLzJzWeYTEiEENUG8eLQuqkXmFVrslUzL01S5U20PDqwEOdI/6dq7pjN+As3Uw7SJ
	 KY94cHFUFy2txQWC4lfIgp5SGT0HxtOqF0JA6y9WCOhx/Vs+1YD0yAAD9IHUts403
	 CLoPotKo3JiKLJ4SovYkGtc0TNVfiHfRDfs7qGmUuXA/QS3kVujmKJYa0IOQheWQm
	 muFvbbsfYxAP/RMeKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.144.196] ([217.61.144.196]) by
 trinity-msg-rest-gmx-gmx-live-67cd9ff8f8-qxw8q (via HTTP); Mon, 11 Nov 2024
 21:41:19 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-57bdaab7-5f4f-463d-9657-377ccfe7df25-1731361278993@trinity-msg-rest-gmx-gmx-live-67cd9ff8f8-qxw8q>
From: Frank Wunderlich <frank-w@public-files.de>
To: robh@kernel.org, linux@fw-web.de
Cc: broonie@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 leilk.liu@mediatek.com, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Aw: Re: [PATCH] dt-bindings: spi: add compatibles for mt7988
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20241111203803.GA1917413-robh@kernel.org>
Importance: normal
References: <20241109105029.52748-1-linux@fw-web.de>
 <20241111203803.GA1917413-robh@kernel.org>
Date: Mon, 11 Nov 2024 21:41:19 +0000
Sensitivity: Normal
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:lhWuv2tYMHpt7DO7Z/Dm56Q7NZVx3nihPbPFXJJSEf5DPtX75eGDbSyV4XaE9W5I2YcGW
 WKtcggTre7VQtvMYnR0+UCnrmrQqQ4YDQglMCWGW0SLXrWdy0kNMJqDC8k2ifbJmS6+Aiw42glBb
 z88/SvPlEczxqExLblIRyHVbcn9fPdCDh7zMIG3OFQKqUjJufbGxQl/jVL2LZwbFd1nRejHbCcPP
 myMMaooIhnQZZjzPlOpCrf5jc+WwQ2Kvve7SGPImdsQqzVSYYUUT5aWX/CmTaW9npY63ELcrMwfu
 jRG5SbNgmAWLsy9JZImnJh43koRoozoCZ0Z7vVBrYArvOeMMjdFlUcJs5VeXi6IEXc=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2iLa3uBn1KI=;niY7MlI2EUB5Nlxhv6aaM1TMYCo
 55wGD8AOhwrMB31IDL4MsTkyZk1d9UybNK9Z34MaSrpVRzXjE6VH7YrMG+UBgghcJc5zmK+Af
 4VgYUDbUQ3bMAmF4mBX5W1dZ7ugyfOcOYsdPoZvycG0k308wrinC/IloXV1/fBDiodJ0mtTK/
 SavEaYcVK9pyhEBo4jm7F4wVeazCuvCaArYi/trYAtCo4CPb8RsDYLmX2wmM9Tt3d4CAmpW0Q
 kqd0mR6GnsnLAvd3bm4Gu+wZLWXlIcFORGVwC1WIXFsh4PHqbPulLmVkqnVqmlzRFPV2ZzUpM
 z2ch847wRtPVyehjJajW7ofxfvPV/Twev297EDbF6jq3yEr01HYOIWrzB/PUB5SD/uBGlK49/
 UCDocskb7i9mpjTB78NA63q2pGop5l6JLhn0GLGulLEFYLEw9Yd3Lr8kvychbpQu9tYJo+d8s
 krnaQh1Lpc/I2fHYq+6T3Aqc2sTxhL7/NnBH0fIt1Duoiw0RfV6WgAwWs6GUwq2XbcypIIkZA
 h0c+6h0fjpaREmRQoV1VmoTyJ4J6bfkFP3Tx/eZhHApLduWQxSlPorx5vMdy0br0+TfNhqueV
 JiApG+yF5EUWqOc/DIkMJ4nVBOeKufHUeSW/1urz8s4j8y+nRyZUt9Szxy0fY7d25gyiy+xr+
 c/2j4p6lSFwRQB4S1HcTESkgSk0S1weiffTTgTUKUw==
Content-Transfer-Encoding: quoted-printable

&gt; Gesendet: Montag, 11. November 2024 um 21:38
&gt; Von: "Rob Herring" <robh@kernel.org>
&gt; An: "Frank Wunderlich" <linux@fw-web.de>
&gt; CC: "Mark Brown" <broonie@kernel.org>, "Krzysztof Kozlowski" <krzk+dt=
@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Matthias Brugger" <ma=
tthias.bgg@gmail.com>, "AngeloGioacchino Del Regno" <angelogioacchino.delr=
egno@collabora.com>, "Frank Wunderlich" <frank-w@public-files.de>, "Leilk =
Liu" <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org, devicetree@vger.=
kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead=
.org, linux-mediatek@lists.infradead.org
&gt; Betreff: Re: [PATCH] dt-bindings: spi: add compatibles for mt7988
&gt;
&gt; On Sat, Nov 09, 2024 at 11:50:28AM +0100, Frank Wunderlich wrote:
&gt; &gt; From: Frank Wunderlich <frank-w@public-files.de>
&gt; &gt;
&gt; &gt; MT7988 has 2 different spi controllers. Add their compatibles.
&gt; &gt;
&gt; &gt; Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
&gt; &gt; ---
&gt; &gt;  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml =
| 2 ++
&gt; &gt;  1 file changed, 2 insertions(+)
&gt; &gt;
&gt; &gt; diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-=
mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.ya=
ml
&gt; &gt; index e1f5bfa4433c..ed17815263a8 100644
&gt; &gt; --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.=
yaml
&gt; &gt; +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.=
yaml
&gt; &gt; @@ -35,6 +35,8 @@ properties:
&gt; &gt;            - enum:
&gt; &gt;                - mediatek,mt7981-spi-ipm
&gt; &gt;                - mediatek,mt7986-spi-ipm
&gt; &gt; +              - mediatek,mt7988-spi-quad
&gt; &gt; +              - mediatek,mt7988-spi-single
&gt; &gt;                - mediatek,mt8188-spi-ipm
&gt; &gt;            - const: mediatek,spi-ipm
&gt;
&gt; Does the fallback make sense for both? Is there some common subset of
&gt; functionality where they are the same?

currently they work only with the fallback compatible, but we see in SDK t=
hat there are 2 types...in SDK non-soc specific compatibles are used which=
 was rejected last time.

&gt; Rob
&gt; </frank-w@public-files.de></frank-w@public-files.de></leilk.liu@media=
tek.com></frank-w@public-files.de></angelogioacchino.delregno@collabora.co=
m></matthias.bgg@gmail.com></conor+dt@kernel.org></krzk+dt@kernel.org></br=
oonie@kernel.org></linux@fw-web.de></robh@kernel.org>

