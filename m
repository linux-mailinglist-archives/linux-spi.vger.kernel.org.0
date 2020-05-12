Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3A41D0113
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 23:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgELVqR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 17:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731065AbgELVqR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 12 May 2020 17:46:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B883620731;
        Tue, 12 May 2020 21:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589319976;
        bh=ulLHlolQRXsWXYiTML1BrCYngQd1LDZaMS96rMIfDoI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W+OUlqzrI5Ge8FBittf7LcuviYyZbh7RW04rzXj0LXbJmBI7zFX31BvgYAIo1XAQM
         XL8YFWUp3Nkbad2exsH3fZKlopfu4Zg7IUCUf1Q0UnAw/lmuhbuuVc7STGue7Ix1Pc
         C1xok6HYkI+k+YIz7N4plBlZmqeamDeYPfz3+OZc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200512204543.22090-5-robh@kernel.org>
References: <20200512204543.22090-1-robh@kernel.org> <20200512204543.22090-5-robh@kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: Fix incorrect 'reg' property sizes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Date:   Tue, 12 May 2020 14:46:16 -0700
Message-ID: <158931997603.215346.13048447179585746005@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Rob Herring (2020-05-12 13:45:43)
> The examples template is a 'simple-bus' with a size of 1 cell for
> #address-cells and #size-cells. The schema was only checking the entries
> had between 2 and 4 cells which really only errors on I2C or SPI type
> devices with a single cell.
>=20
> The easiest fix in most cases is to change the 'reg' property to for 1 ce=
ll
> address and size. In some cases with child devices having 2 cells, that
> doesn't make sense so a bus node is needed.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org> # clk
