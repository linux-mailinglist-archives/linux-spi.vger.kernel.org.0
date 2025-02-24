Return-Path: <linux-spi+bounces-6898-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F36EA42DCE
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 21:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA3E1757B8
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 20:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72FD23F277;
	Mon, 24 Feb 2025 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4pVeK2S"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72147209F41;
	Mon, 24 Feb 2025 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428894; cv=none; b=EumTRRF4ngWjh668hgWiL4SPNOOqaEnSM6vkp87y9jn1xviGQu440gdqb5Tp/E02Y6KzR1K/vQlbIXN9zR9rKevwWSR8ULgg6CbpNNN3Um/TxB4+h69ekegO3u5kD/DTGFs6tWthM/NJzrZRY1Ju96YnfnqIhkBmAGHf6tJnwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428894; c=relaxed/simple;
	bh=0m0T6PyoD7xkTGj6kIv+HfKEEBh/taWnpcicr5ltFaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eS7OrtXRx1T723HYf7VBq6R8j3Gho45Z3cgjGUkOEYGgp8NvYVscdSu1OZiChmdGptneIQFf3RhIZwEFiVgf+yQOYxHUvu9ED9RXM37YCPBg7/as8BsvFWvMh9xbC2kEM/Oqtc0+e46ngiUKW80LymXIw3N+WEbDtl/QQfF8iJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4pVeK2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17C9C4CED6;
	Mon, 24 Feb 2025 20:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740428893;
	bh=0m0T6PyoD7xkTGj6kIv+HfKEEBh/taWnpcicr5ltFaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4pVeK2SAold59ncUwUm/pyD8iI0WLAIYOKhCWSX+LTScDIKxbZVAfK13ab4tYsk5
	 xN76WQSCw2MyPUtuJK2U0YkMfc60jTSBPzuprSJqQ0PlDcIk7WBNUYAqdPW46lSww3
	 QchBWaPqYhjQRSfImW42wQ/emDJahVcxkcKf+Ri9fdKXNp1ID+7H3WEpAGF05TwlAU
	 1mo7Z4mTO0pdL4LyIq66nL0KrO1BA3YpKnnRLo2kmYQTCvjGueaUxTXeNFO+Zqsoo3
	 Ai+j4rHfKFzWTB6RSvPTEOiujr4rV0NvRIvQE6uBFeQn1jJSFJswqWEBrgHIzGuDM2
	 rKQD+BMM0EyOw==
Date: Mon, 24 Feb 2025 14:28:12 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, Chen Wang <unicorn_wang@outlook.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: spi: add Sophgo SPI NOR controller
 driver
Message-ID: <174042889175.4042827.14947254444698691602.robh@kernel.org>
References: <20250224101213.26003-1-looong.bin@gmail.com>
 <20250224101213.26003-2-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224101213.26003-2-looong.bin@gmail.com>


On Mon, 24 Feb 2025 18:12:00 +0800, Longbin Li wrote:
> Add SPI NOR driver for Sophgo, including read, write operations.
> 
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> ---
>  .../bindings/spi/spi-sophgo-nor.yaml          | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sophgo-nor.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


