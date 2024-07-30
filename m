Return-Path: <linux-spi+bounces-4100-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A830694204C
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 21:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE661F23EFF
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1BF1482F3;
	Tue, 30 Jul 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=urja.dev header.i=@urja.dev header.b="aUFxCHV5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BBA1AA3C3;
	Tue, 30 Jul 2024 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366478; cv=none; b=C5TWEeL6z58zRH7aSUPgboEvJtbzR8DgvbxNW9KQZN2TP7BNaF776iq3z5ogIoINbr3VYMpRd957p5281IkIOCaPeWNQBGNaN2LU0ibvWxaAmLRkSC0It/lb+/Gbl0dWUH6Lfz3Crmsi4ksdCib1HFq/2+8qY/PX5hbcXObpfzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366478; c=relaxed/simple;
	bh=saWhBVeizg0sVdQ6Vyt/B9QfErmZv7ysjEY0xq8TAOE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdNU4G/7dL/zX4VH5coXlzz4Hp1nF1JhtTB/hpWHFl+zk06h2IbB9VmkXi+CU2wHq2PZB53m3GUiVmWL2jgfURhJk7CuntgU+pZp5vzUoSRHBiYpAK/pkfw7YdkLNcKwn24aiHwRxl0WdV+RttqaOtlnbVevbzLLNQMK9tL/QdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urja.dev; spf=pass smtp.mailfrom=urja.dev; dkim=pass (2048-bit key) header.d=urja.dev header.i=@urja.dev header.b=aUFxCHV5; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urja.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=urja.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=urja.dev;
	s=protonmail2; t=1722366468; x=1722625668;
	bh=saWhBVeizg0sVdQ6Vyt/B9QfErmZv7ysjEY0xq8TAOE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aUFxCHV5ErqO3t7yUec1AfkzKBfaFOwLT82kEXZZrP7LeW8bxa6e0Sd/5pGIstwbp
	 38uzczgEbnprMAOobCU8H16XypQucvojDavpe/Di2dVSsWbwrZWuNYbkC/nDmg4IVA
	 DTHyAtNY4gisw7thO38HFgC92/taDGBZeXpWt/9ZUlZQCo8EB320A9kuyWeRMTNbjl
	 GxRvPUlvjY7jFIBOrlMy85Ps/A2o+UTbGMR60qaCCpu/iRr8wh2hVBHCzsn9SkQwf6
	 l96gFluuMUMEk8xOFbQpZXIIv9FveJ7ennssyZgZ+E1p9Rw0Rn6owlMDdGXtiGtICW
	 bnZIbMi1ZEtjA==
Date: Tue, 30 Jul 2024 19:07:44 +0000
To: Sebastian Reichel <sebastian.reichel@collabora.com>
From: Urja <urja@urja.dev>
Cc: Lee Jones <lee@kernel.org>, Dmitrii Osipenko <dmitry.osipenko@collabora.com>, Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: rk8xx: Fix shutdown handler
Message-ID: <lJ87fvo0QzsVinjBdNVA7jnCEFm0-GBVJhFpFwKWCIS1M-kiuXP_mefSzm8G2Iplic1LlekmwUD6OODDJAtiDOPuDZ08HT965Tkmibgn6fE=@urja.dev>
In-Reply-To: <20240730180903.81688-1-sebastian.reichel@collabora.com>
References: <20240730180903.81688-1-sebastian.reichel@collabora.com>
Feedback-ID: 82529409:user:proton
X-Pm-Message-ID: 6ad94b037d6329c541045aad68e64fee5a4c1d46
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tuesday, 30 July 2024 at 9:05 PM, Sebastian Reichel <sebastian.reichel@c=
ollabora.com> wrote:

> To avoid this we keep the SYS_OFF_MODE_POWER_OFF_PREPARE handler for the
> SPI backend. This is not great, but at least avoids regressions and the
> fix should be small enough to allow backporting.
>=20
> As a side-effect this also works around a shutdown problem on the Asus
> C201. For reasons unknown that skips calling the prepare handler and
> directly calls the final shutdown handler.

I can clarify that bit a little - basically, when the handler is registered
as a poweroff prepare handler, the kernel thinks that the C201 cannot power=
off
and converts the poweroff into a halt, so I assume the
power_off_handler_list is empty - which makes sense, the C201 has no firmwa=
re
to call or other poweroff methods that I'd be aware of.
(See kernel/reboot.c line 746 and 683.)=20

Anyways, this patch works on the C201 (tested on top of 6.11-rc1).
Tested-by: Urja <urja@urja.dev>

Thank you
--
Urja Rannikko

