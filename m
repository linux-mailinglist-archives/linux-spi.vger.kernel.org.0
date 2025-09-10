Return-Path: <linux-spi+bounces-9957-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AB6B50A3A
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 03:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D39442169
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 01:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955DA1F37A1;
	Wed, 10 Sep 2025 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnGlidRu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662411F03D9;
	Wed, 10 Sep 2025 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757467594; cv=none; b=TnSEdteuS0SgIbokPH6RIbs9QhCm7D5UqSvLfCGoUZ0Ujbjlb2+6K1EXwWX12qae1Y/LiYpoca9mD21AqPTsDYg//0jJXRN6edRKWQgGkuP4zBw0V8/YWHSOshWF45yIfkMOE01654t+m8g9je3tS6GsbOvKVZ3qrIwxZKWy/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757467594; c=relaxed/simple;
	bh=yIRu3Ue/IKYOYSOl6HV7wEi1g8o7rUFyW17908DZ2As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ll9DlPz+iD85g9xPr1Qn04s0nLQrjCLz2ELyN3pSbCLotKHMX0RXhXH37SALoNFUTcnN5+lAjlCS2NontDesrSs+WYFXq/p/b7aFQSH5s1gqJEiD9+I7BVCQVV1HvkRQXu7G1gdg0qHssGqANnaGm4S7KFPjPF6hqiX5Gc/twLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnGlidRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08B0C4CEF4;
	Wed, 10 Sep 2025 01:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757467594;
	bh=yIRu3Ue/IKYOYSOl6HV7wEi1g8o7rUFyW17908DZ2As=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mnGlidRujmGdz7aCbupfuOeM1TrmuEG9czEo1ZnMcmdIdumimh8hZstGJwRcpVzBP
	 1W/ccJXF5QBqNGKUNyQ43LOUBVoqkO/ilq7YaitxXMigsRUMZJrVk08oDp2US+PTm4
	 DlOos3K8393/PParXcEndl9u9TZw+myADyCM4IwRgFLVUPGnQhtEdtJYuIoOEta8Hg
	 tXsyMSWB3DnckF0dReJ0jwK7213Zrn5OFD5VMEyqWSuddBq3Vy5HyQLX40hPYsMaTJ
	 dME/nCMFmiGiJ9KeA4K+Cl42gmDigy1nbgCsRZRkGZ1i7AFZ02WLKc6kNSlMePtu2c
	 wOh3YjFhAUqlA==
Date: Tue, 9 Sep 2025 20:26:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: spi: Define sama7d65 QSPI
Message-ID: <175746759249.3565236.61405716277670882.robh@kernel.org>
References: <20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com>
 <20250908-microchip-qspi-v2-2-8f3d69fdd5c9@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908-microchip-qspi-v2-2-8f3d69fdd5c9@microchip.com>


On Mon, 08 Sep 2025 09:44:17 +0530, Dharma Balasubiramani wrote:
> sama7d65 has 2 instances of the QSPI controller:
> 
> • One Octal Serial Peripheral Interface (QSPI0) supporting DDR. Octal,
> Twin-Quad, HyperFlashTM and OctaFlashTM protocols supported.
> 
> • One Quad Serial Peripheral Interface (QSPI1) supporting DDR/SDR.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  Documentation/devicetree/bindings/spi/atmel,quadspi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


