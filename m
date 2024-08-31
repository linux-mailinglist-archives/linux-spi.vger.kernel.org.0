Return-Path: <linux-spi+bounces-4489-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5337966FC3
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 08:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A151C2194D
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 06:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B68E15C156;
	Sat, 31 Aug 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRoHtdHd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F3C1E493;
	Sat, 31 Aug 2024 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725085410; cv=none; b=N31iAcFXH+P2+CLM4kewrjhfii6SHd/3y/bKYB5c5q//IKHG2bBKU/cKlxDEpWmTc7SNynzZIMtgGGTW733TKbDz7z/OvtsT8sxgOZ7dPIWYVurAZW8C0onPi6iNmO7l296kp+1lsQRN9Hvb/Ac8gkCwbju8TQYoazRDAQyl2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725085410; c=relaxed/simple;
	bh=bRNfiGRxfdz8XKeOi6s0p/bqBMfMbr0d5Gc66yCOE68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPSTcvPYMnGfpBn30EVhrvDkCjTCj0EcXc2Iz2DJgEzrKJApBRKWj+2aguQz/AZTNxW3EQNHorD/8YS1COGvLbXsQWq4d5BfFl3aYvNSZyJ4QkO7rucfu6Ih34r5bJ638gByqm/rFufXacZhKdi2MV5/mQvOGttmDXKi5KhO5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRoHtdHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E5CC4CEC0;
	Sat, 31 Aug 2024 06:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725085409;
	bh=bRNfiGRxfdz8XKeOi6s0p/bqBMfMbr0d5Gc66yCOE68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRoHtdHdOkFzmPNKWC7PE4AK3PEytKSWPhRCWTSIzUB2kD7anv8odmlxDXZNLlXKT
	 nKNU0jLJmRsZtJQWWdMfsZ9vPfPFNbdsNuIX09vm9B+q1KGcvjzp4//XHFZEQ3rplf
	 OkMkWWa3i5S/oHIR24bThBcZmz2b040QtkROy9ta9XWfAjZsAKSFHs0Mr66JlaqZ2M
	 X96sEnGa7LQapHjC7EY/NDyek2TzqGqoGjFK+mTYTNGMgvQtrVLp21Exi0ZaZzh5YK
	 07G6pxXF8WGcb+CnEhLhetAcpEEqCKo9AOsNpKBhCYuMRbnOHCcyJoWBQzkbxMGgbl
	 QCQ+jpCNl5xMw==
Date: Sat, 31 Aug 2024 08:23:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	otavio.salvador@ossystems.com.br, heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: trivial-devices: Document spi-cpha and
 spi-cpol
Message-ID: <cyjfrkrszis2ye6vbuasblze4ufesk3wagfwrva6ljv4yfxnxc@2sqin2agzmle>
References: <20240830171849.3750165-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830171849.3750165-1-festevam@gmail.com>

On Fri, Aug 30, 2024 at 02:18:49PM -0300, Fabio Estevam wrote:
> There may be cases where a trivial-device needs to describe
> the SPI clock polarity and phase via spi-cpol and spi-cpha
> properties.
> 
> Document these properties to fix the following dt-schema warnings:
> 
> rv1108-elgin-r1.dtb: display@0: 'spi-cpha', 'spi-cpol' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v1:
> - Add spi-cpha and spi-cpol to trivial-devices.yaml. (Conor)
> 

No, this does not look correct. Why suddenly all devices get CPHA/CPOL?
This is supposed to be only for devices REALLY needing it (as discussed
with patch moving it out of spi-peripheral-props, did anything change
here?).

>  Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Best regards,
Krzysztof


