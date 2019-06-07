Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC839184
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2019 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfFGQC0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Jun 2019 12:02:26 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:37870 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfFGQC0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Jun 2019 12:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559923344; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UMeb8s3x07TTN4QCSKpfksq3u9KWy8EYAfG5xqeLnbY=;
        b=RbIKxQXW0mMeb6tEiX6on3QzWynmDcKV9nSa3AmarxPyPXwmLllzL1rwPZ7mZtJ+Rqmd06
        crtWpwR/POs+e7CpXstpg5+rLpUgLdDeril+nVgF/gJKK76iHhJeZQKPwK/gomK9DfhCvI
        UNzOsM6s7P22GI7JLWngPue0pFQmYeQ=
Date:   Fri, 07 Jun 2019 18:02:20 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] spi: spi-gpio: Make probe function __init_or_module
To:     Mark Brown <broonie@kernel.org>
Cc:     od@zcrc.me, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1559923340.1918.0@crapouillou.net>
In-Reply-To: <20190607155907.GH2456@sirena.org.uk>
References: <20190607155631.15072-1-paul@crapouillou.net>
        <20190607155907.GH2456@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le ven. 7 juin 2019 =E0 17:59, Mark Brown <broonie@kernel.org> a =E9crit :
> On Fri, Jun 07, 2019 at 05:56:31PM +0200, Paul Cercueil wrote:
>>  This allows the probe function to be dropped after the kernel=20
>> finished
>>  its initialization, in the case where the driver was not compiled=20
>> as a
>>  module.
>=20
> Hopefully not since we might probe later on if something registers a=20
> new
> device...

Makes sense. Sorry for the noise.

=

