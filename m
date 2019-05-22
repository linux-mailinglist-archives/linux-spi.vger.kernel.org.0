Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D093526225
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2019 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfEVKma (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 06:42:30 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:57261 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfEVKm3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 May 2019 06:42:29 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 666F2240009;
        Wed, 22 May 2019 10:42:27 +0000 (UTC)
Date:   Wed, 22 May 2019 12:42:26 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: dt-bindings: Convert Arm pl022 to json-schema
Message-ID: <20190522104226.nwcvx33akt6q576m@flea>
References: <20190521212325.16639-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521212325.16639-1-robh@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On Tue, May 21, 2019 at 04:23:24PM -0500, Rob Herring wrote:
> +allOf:
> +  - $ref: "spi-controller.yaml#"

You're using a different construct on the spi-gpio binding you just
sent (/schemas/spi/spi-controller.yaml).

Is that on purpose?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
