Return-Path: <linux-spi+bounces-8631-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CECF5ADE656
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 11:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBFC1897911
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9D527FD4E;
	Wed, 18 Jun 2025 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zy1Rwuwu"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9327FD4A;
	Wed, 18 Jun 2025 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750237951; cv=none; b=g/wAgGdHpA2MB+46CXGqxzJN9bXD4+KaPBI1gXa7TEyhiKcXXANWfbe/v1u+g9Mn9CU8/6RbXDqpsySaiFRgToFqr3NNRdLg5ltUT9evvRWrY59An0W62+1d0SCc5TYQl+PVN02ZhHOamS81Ab+4LzT7YULXFuVusSkesogt8UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750237951; c=relaxed/simple;
	bh=cj6KRD0up+ErYS+u+qJncczJtEr5FTwpg3NwGMa9s/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iM/45Yg8RiFl12jjkQGox2Is8N+xJPKyhL8SjBx0sL0P4N2CDGWjREHf8azAxfKC6S1iq/iB146v68kaXNw3oEMPDjYeYnLB8P5qD86jr1EyIZ6sBey+AgOWwd5JQT+A3DzjAwMsZ9ZCgAKexZVbw4rXn76QjKNfWfp8DWbhNNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zy1Rwuwu; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F216C442DD;
	Wed, 18 Jun 2025 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750237946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cj6KRD0up+ErYS+u+qJncczJtEr5FTwpg3NwGMa9s/c=;
	b=Zy1RwuwuMUY2gqRqK8VF9qHB4Zg8JNw0Z6EJbt6lzo982uKdDFH16wzC1d858R3tjaoaEn
	UTAPopdQetgAQrAXZlHbn/ZsxEllWfCzZKnu8IrI0/5lyjJUvFzhWnOu4CX0QT9LGAX1Zj
	bgEbLI69ACbdtti9XaBGiaI3x9NOEZVkzgxdgNp1YkOH6hOP9GAj2rASp3M1ttRpWAqgr4
	qia26896ElN3P5rt+fyIij8/xnBPoHb1rBhB7iVOWaDEArjqFJAK1RY3J5zVrAcwk2L0+M
	6xFLCUrY2Uik3mGlmC3fkmE4fSk6029rnab0VhuCJf5eotjro8QSIr/PHDvhZQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,  Md Sadre Alam
 <quic_mdalam@quicinc.com>,  Varadarajan Narayanan
 <quic_varada@quicinc.com>,  Sricharan Ramabadhran
 <quic_srichara@quicinc.com>,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-arm-msm@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-qpic-snand: document the limited bit error
 reporting capability
In-Reply-To: <20250527-qpic-snand-limited-biterr-caps-v1-1-61f7cf87be1e@gmail.com>
	(Gabor Juhos's message of "Tue, 27 May 2025 13:08:16 +0200")
References: <20250527-qpic-snand-limited-biterr-caps-v1-1-61f7cf87be1e@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 18 Jun 2025 11:12:25 +0200
Message-ID: <87zfe5l8g6.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepjhegghekhiejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghmuggrlhgrmhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehquhhitggpvhgrrhgruggrsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhitghhrghrrgesqhhuihgtihhntgdrtghomhdprhgtphhtthhop
 ehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhmshhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg

Hi Gabor,

On 27/05/2025 at 13:08:16 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:

> The QPIC hardware is not capable of reporting the exact number of the
> corrected bit errors, it only reports the number of the corrected bytes.
>
> Document this behaviour in the code, and also issue a warning message
> to inform the user about it.
>
> No functional changes.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

This change no longer applies on v6.16-rc1, can you please rebase and
resend?

Thanks,
Miqu=C3=A8l

