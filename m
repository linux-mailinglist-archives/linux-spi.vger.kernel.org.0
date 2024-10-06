Return-Path: <linux-spi+bounces-5112-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F3E991E53
	for <lists+linux-spi@lfdr.de>; Sun,  6 Oct 2024 14:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455F7B210C0
	for <lists+linux-spi@lfdr.de>; Sun,  6 Oct 2024 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2F5175D29;
	Sun,  6 Oct 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK5NfoEl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4C1171E70;
	Sun,  6 Oct 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728218891; cv=none; b=G3JQiOpMRx9fvPb2b6mhOyeO+N2HJFpTdyiy40ihK6DZ9BPwmQ1NcYl/eKoCAj6jScuPwtBneGppcTsQnXRdoTIG4oFeD7AiTYyCjc5el0Vcha5IAlBlU3pxeuby2p+DjN7O6Yaiafn0FdfrzZHEj2HLi5CZmjv+qMGA/WyJVuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728218891; c=relaxed/simple;
	bh=EC+uOqpK9Zdf6/1C0U/deKBs4TGD19dRrEPioHxLh0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2CwFu4XvMvdMIteDdaNwoyNhvtyc6qMc4kH1oqoGTkNNeWnQ24bwuONn8sdqtvCLMp18rzgXs7SZXQSHBeRTLE04Qfga6eziWXcS1Zk7OvzAqy4DRC4q8Yfui+xcVR5s6G8ex0ZY3aMI+u8ou9xKIsi1xyeXdVYS1gZWP81Hj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK5NfoEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCBEC4CEC5;
	Sun,  6 Oct 2024 12:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728218890;
	bh=EC+uOqpK9Zdf6/1C0U/deKBs4TGD19dRrEPioHxLh0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YK5NfoElqmkBgts0p0Byk1UTMJEpi9y5sEN/VSX2SszHkVyyoorXtZrOybWepWi8q
	 q+2LCO1UIgQjJ/SKnmqGNcNIna/R4eGskHIWcADQprP3GCVQfjWrBD3gmtq1aWyBEQ
	 oV9ItvEAIpc55+dzMTyDpZnTucGk0lbfyzXdWG9Lhce4gjyjIiN26LucMdYsP9Zg1s
	 mgYFx9I7KuXi/go1oy8ZSBobya2+Q6LSsGY8hnwUJavq0Ek6SRLYxV7z1UDc7FQK3Q
	 6t5WsTSGyU+3xrrJabNHps2ZVqIcJbGWl/DIa5LroL5hN1tfVuWpCah14HKt79A8Fb
	 KRAoaeD74GYOQ==
Date: Sun, 6 Oct 2024 14:48:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Frank Wunderlich <frank-w@public-files.de>, 
	Leilk Liu <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, daniel@makrotopia.org, john@phrozen.org, eladwf@gmail.com, 
	ansuelsmth@gmail.com
Subject: Re: [PATCH v1] dt-bindings: spi: add compatibles for mt7988
Message-ID: <kmzl5zmqqudoq2jcdacfsbwq3axdvcml4m5kw5oqqo2hj6iiuq@xzeg6penuic3>
References: <20241006102740.17948-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241006102740.17948-1-linux@fw-web.de>

On Sun, Oct 06, 2024 at 12:27:39PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> MT7988 has 2 different spi controllers. Add mediatek,ipm-spi-single
> and mediatek,ipm-spi-quad compatibles.

Why generic compatibles?

These are supposed to be SoC-specific.

Best regards,
Krzysztof


