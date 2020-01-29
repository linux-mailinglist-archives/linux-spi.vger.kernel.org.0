Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2949814C59C
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2020 06:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgA2FSd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jan 2020 00:18:33 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:38363 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgA2FR2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:28 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDk1H38z9sS9; Wed, 29 Jan 2020 16:17:26 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8c452a889821ca0cd2a5f2e3e87fbc01e56408cb
In-Reply-To: <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] powerpc/devicetrees: Change 'gpios' to 'cs-gpios' on fsl, spi nodes
Message-Id: <486sDk1H38z9sS9@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:26 +1100 (AEDT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2019-11-28 at 12:16:35 UTC, Christophe Leroy wrote:
> Since commit 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO
> descriptors"), the prefered way to define chipselect GPIOs is using
> 'cs-gpios' property instead of the legacy 'gpios' property.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8c452a889821ca0cd2a5f2e3e87fbc01e56408cb

cheers
