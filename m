Return-Path: <linux-spi+bounces-9160-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABAB0F451
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jul 2025 15:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F753B527D
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jul 2025 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1212E7F07;
	Wed, 23 Jul 2025 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="MyEuCp8j";
	dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="VrfC2+B5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.adomerle.pw (mail.adomerle.pw [185.125.100.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C952E7165;
	Wed, 23 Jul 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.100.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278210; cv=none; b=uMDrK0yIMarL2/gwQvwh1Q+YHqirPEYJHHGFy1gbTzuuDsmXzXJgeUjFey2EeBOHJgvD+LJZ1FFuhkSWl6QyFUKAZKRDKkeQU7ihoX/HHenveLnZXQLr7XnHOkus6bT3K/4dq6PYEyjhrQ+T4mKn6ikXHJ55xbWNx217o38xJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278210; c=relaxed/simple;
	bh=axLciYc0DjxkH9pCxsN2v6yAL/K5kNdDcS6CRQnvp7A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WqPrqXuR50TGYm6xzrwUsb+wJXyHy+Fdz0Mqy3RQTB4CICblMwhHYngqoPvHGtLHFFD1L7BVngWXlMhx/buPUZ45Q1807yp7nbiTx+HZiiya685Jve038a3XCAho3YM5zwDmb2QMysmcpIJndQtvhCZSgdApfrF4DqgzoQMl0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw; spf=pass smtp.mailfrom=adomerle.pw; dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=MyEuCp8j; dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=VrfC2+B5; arc=none smtp.client-ip=185.125.100.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adomerle.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202506r; d=adomerle.pw; c=relaxed/relaxed;
	h=To:Subject:From:Date:Message-ID; t=1753278174; bh=eWmW202fKN2m55O+smSp46+
	HpeMk9N6O4tiZVZkb404=; b=MyEuCp8jLg3wVPiud2UbpWmVecvRtsBgHmk0wFbcKT0UQGl5uB
	+ULUxVUCfThbckljFSg4ucQsiD7wL43Yzn9WiyZcvKoVSWyZSOJRWxG+nej/xl8p5S7QjOm71aE
	nkMXT22G29dBlb90mRNyTBciN1duOUOZTCVzalIQvVkStbM09kHinSlIMRJjePNvmBrS38d/Bn1
	E2HhqIMZxbOoW2XP9KSMiqju9KPnFbA9vmGQFJvZzTcD24MNgMyifA4bkvK6GhAVq+aVZHwwCBs
	8Kqg8AeNBcUbmQT2io5pUX6TxwfCAF3+VhUfLQE09teaq46mzT+Ty8akSgRpg+UQtCg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202506e; d=adomerle.pw; c=relaxed/relaxed;
	h=To:Subject:From:Date:Message-ID; t=1753278174; bh=eWmW202fKN2m55O+smSp46+
	HpeMk9N6O4tiZVZkb404=; b=VrfC2+B5FlWRLIEq4PKFokKKZ4PVXdA4j+Osyj+L1kI9BPgFf8
	hbg1/rpADS6lx/f2JfuFPIrm30tIKlfptwAw==;
Message-ID: <3c6cb602-63c4-4384-b4f6-1705167d3759@adomerle.pw>
Date: Wed, 23 Jul 2025 17:42:52 +0400
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Arseniy Velikanov <me@adomerle.pw>
Subject: Re: [PATCH v1] dt-bindings: spi: mt65xx: Add compatible for MT6789
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Leilk Liu <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250715231921.4527-1-me@adomerle.pw>
 <20250720223451.GA2915764-robh@kernel.org>
Content-Language: en-US
In-Reply-To: <20250720223451.GA2915764-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.07.2025 02:34, Rob Herring wrote:
> On Wed, Jul 16, 2025 at 03:19:21AM +0400, Arseniy Velikanov wrote:
>> Add a SPI controller binding for the MT6789 SoC. As a note,
>> MT6893 SPI is fully compatible with this SoC.
> 
> Then you should have a fallback compatible. Otherwise, there is no
> driver change here, so how would this even work?
>
Thanks for feedback! I plan to send a fix in a new patch series, where I
will add support for all compatible hardware.

-- 
Kind regards,
Arseniy.

