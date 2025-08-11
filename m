Return-Path: <linux-spi+bounces-9351-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7202B2148F
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 20:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBD73E3FD7
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 18:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDDC2E2DE2;
	Mon, 11 Aug 2025 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfdZHXTG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD032E2DDD;
	Mon, 11 Aug 2025 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937675; cv=none; b=WhfaT++mb/B9WV8jM5eK9X8u50M6xkrhCoqTfQzUElG9rKaVmTFFzvP6zJP6ikl3i/9QEONxBdcvo3ttw7EJsQeCg2DG5jZ+y+BdKJqpKCZOFsQfdLW+XxHuneuGXJM3DJ3Y36lan9mT2c+jsmURCquxqIRxIShc/nsJWyCPLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937675; c=relaxed/simple;
	bh=fNekBiIqJVoWfWojnpKyxxW8r/axma2XkS+M8s9SfMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTTQC9651D4NW4ECUZtJcJnGP56IQSrDXlbwfGbxGw3+E9ObNpWCSX48qHBG/4zyaChJR9+ZqrFWa1y5Zln4IKvqwfKXlEAWwgifNIJJwnXEdvweV9jpL2YmM07fxWtRI/cdx7AAKsYsYJTyna1OmbOijDpNs78upteLIwfXNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfdZHXTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC00C4CEF6;
	Mon, 11 Aug 2025 18:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754937674;
	bh=fNekBiIqJVoWfWojnpKyxxW8r/axma2XkS+M8s9SfMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NfdZHXTGsAo42hKE3jqxNyxUC2m0OgZJ6Mafy5f0qC7ykokNjbYL3qOZEZknbBQcv
	 RHQ7MVah3YOraqhpYKUCL4Ce1SXXXtpgvIcyatjH+HS3o/RdX5Evo8/HGbfhPYOkcq
	 w32SGS8zLIprGPY8/JUfaDRSzLMfHQ7uJsgMMPU9kS5CTCtwiFu2priFb7imY1MK/q
	 JUrtlbQMXh11daK6m3lG2fRLyyqSfHhfGJv+jkv10GcTJm6dS3RdQMFlkmn8yC+taO
	 RqjxxAx+S9njTfAKENGdJIP74dAYECIz7qBfqtC/vK5HhZ51spfNEK7IR5zqVu8EsZ
	 76JTjRA06pTfw==
From: Bjorn Andersson <andersson@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	sadre Alam <quic_mdalam@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Add QPIC SPI NAND support for IPQ5018
Date: Mon, 11 Aug 2025 13:40:53 -0500
Message-ID: <175493766106.138281.13445269133786197923.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501-ipq5018-spi-qpic-snand-v1-0-31e01fbb606f@outlook.com>
References: <20250501-ipq5018-spi-qpic-snand-v1-0-31e01fbb606f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 01 May 2025 13:20:50 +0400, George Moussalem wrote:
> Add support for the QPIC SPI NAND controller found in IPQ5018 which is
> the same as the one found in IPQ5018.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: ipq5018: Add SPI nand support
      commit: 8d2a8e8dc448f218b36b3b9f3790c9c0dfaa2b74

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

