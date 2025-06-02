Return-Path: <linux-spi+bounces-8353-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06108ACAB68
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 11:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6F53BC14E
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 09:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD15B2AD02;
	Mon,  2 Jun 2025 09:31:30 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7194AD5E
	for <linux-spi@vger.kernel.org>; Mon,  2 Jun 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748856690; cv=none; b=ZzcPMelxRbjf4wf/fhjWubzviXv7JcU/GY9if4dFzMPvu3YJvlevuxsRe/9aAP7SWTMuP/oYcedOtgpdpTJOISSNbsIdkPgv/u1RkXLBwH+EbBANX87hOJs0J7EEGjaifLKslO4bMeSLeMeyBUNx2PhcoHU4YIuZWcQuWnPF608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748856690; c=relaxed/simple;
	bh=DDQCYoxGnWSY2S+soWqfqhkVaAWwzBsBgbxvaeWkF7I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ipiSJsEdjGxpS10vFBj1LXm+ijB7vbFGcJ0QxK2V18mTzovjhOtiKWryYjk+oMFRjelrygq5HmgOFsEZQUJDeN6on+gn5ZE37NnMvv+B60QMZoB6bakqgBYESib6UYORvSscIYvOOSfoxxppk74L4lyr6QVDvru9h1BSVD/QT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uM1Vr-0003wb-C5; Mon, 02 Jun 2025 11:31:23 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uM1Vq-001Qlw-29;
	Mon, 02 Jun 2025 11:31:22 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uM1Vq-000A3f-1v;
	Mon, 02 Jun 2025 11:31:22 +0200
Message-ID: <83e59280261ad0769dd7e9f6135656c795836878.camel@pengutronix.de>
Subject: Re: [PATCH] spi: bcm63xx: fix shared reset
From: Philipp Zabel <p.zabel@pengutronix.de>
To: =?ISO-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>, 
 dgcbueu@gmail.com, florian.fainelli@broadcom.com,
 william.zhang@broadcom.com,  kursad.oney@broadcom.com,
 jonas.gorski@gmail.com,  bcm-kernel-feedback-list@broadcom.com,
 broonie@kernel.org,  linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Jun 2025 11:31:22 +0200
In-Reply-To: <20250529130915.2519590-1-noltari@gmail.com>
References: <20250529130915.2519590-1-noltari@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

On Do, 2025-05-29 at 15:09 +0200, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> Some bmips SoCs (bcm6362, bcm63268) share the same SPI reset for both SPI=
 and
> HSSPI controllers, so reset shouldn't be exclusive.
>=20
> =C3=81lvaro Fern=C3=A1ndez Rojas (2):
>   spi: bcm63xx-spi: fix shared reset

Both drivers currently enable the SPI clock before triggering a reset.
Can the hardware cope with being reset before the clock is enabled?
That could happen for the second device to be bound [1], unless the SPI
clock is shared as well or already running for another reason.

[1] https://docs.kernel.org/driver-api/reset.html#triggering

regards
Philipp

