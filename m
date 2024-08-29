Return-Path: <linux-spi+bounces-4437-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114DB964CF5
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 19:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C701B212F1
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 17:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C701B6555;
	Thu, 29 Aug 2024 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="AYMUKLJs"
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D01B4C44;
	Thu, 29 Aug 2024 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953121; cv=none; b=tPwINJrhSt5m82CW5gKsOYjDQsspzKHvdZJihuwT0GfaLXX1iIzseZ4PplPM8EjLM7wttlSysyfEBS6bKDctKGPUNqZNFd9cbxq+ghXVrU8yUKmPcJsGdBrVTYnp0d2UTC0FuUKymQDfbgbXZ5EuujHRn9eN5pYw6/3CyVIMZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953121; c=relaxed/simple;
	bh=iUZuJDrX9ZCyDiScHZcmvpChppvQPn95ftrnhhWiZs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaVPOiGFhtShKSyWk41VrMUOBzeLVPcclhQuqsmNPeJl4fnuVg/0SE6aPtAwzFJnTcJ3Cij1J4Nu85f0KTAALqYvIOqOl576nYE+F7aWf1bWKUrGcRTqUrx6vM7DyQzHEG+avSKJXADk4MMcvLFApN9hjag5h7GezUQTmTMXW6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=AYMUKLJs; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Plp5DX+Te9E+EY3b2uW6L81CVJ7wlrjy8Vm9YvCwdc=; b=AYMUKLJs02skmOJpENIs1THrHQ
	7O3ZeTn9ftRwhQx+k1XHcOnqp0eju/4a0N7FKuno0mWFb+PWMrXkhrKqZ4OVrG6HMYoWwbixdaLAG
	hX4p7vDRSWZE56Su7rKrZIAauS0wI8sCMW6QkRFn0OZS0Xth3PlRHJIfP6vrIL1BC260IMo5WQdZA
	a48kRpyXekXXwbbHKCLNZOq/g+HoM0wNkXbKAkw8OTrfr9ZhdCV06vNv0anlemxOcZ2X1DJ9l5QW2
	18sjLu53LE57rjgo/hMiPG0lO6KgkfMiDvdS5VZqA9607IYW5W60J+rT4bB7/8mTrncjhOnMTRs4R
	Cs3dK/Fg==;
Received: from i5e861916.versanet.de ([94.134.25.22] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjj6O-0005nl-Fj; Thu, 29 Aug 2024 19:38:32 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org,
	Fabio Estevam <festevam@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	conor+dt@kernel.org,
	otavio.salvador@ossystems.com.br,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v4 1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
Date: Thu, 29 Aug 2024 19:38:29 +0200
Message-ID: <172495310225.1750958.17608946030084833882.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829113158.3324928-1-festevam@gmail.com>
References: <20240829113158.3324928-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Aug 2024 08:31:56 -0300, Fabio Estevam wrote:
> The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> The marking on the LCD is JG10309-01.
> 
> Add an entry for the "elgin,jg10309-01" compatible string.
> 
> 

Applied, thanks!

[3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not describe unexisting DAC device
      commit: 0296f20c72d23f41ca0ccd64eb849e9ef1aa8977

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

