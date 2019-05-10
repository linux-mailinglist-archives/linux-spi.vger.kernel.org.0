Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EF319A38
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2019 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfEJJGQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 May 2019 05:06:16 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfEJJGQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 May 2019 05:06:16 -0400
Received: from [192.168.178.187] ([109.104.54.236]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MXp1O-1hCvYv1g3Y-00YDDx; Fri, 10 May 2019 11:05:57 +0200
Subject: Re: [PATCH] spi: bcm2835: Remove spi_alloc_master() error printing
To:     Nguyen An Hoan <na-hoan@jinso.co.jp>, broonie@kernel.org,
        linux-rpi-kernel@lists.infradead.org, eric@anholt.net
Cc:     linux-spi@vger.kernel.org
References: <1557477738-20634-1-git-send-email-na-hoan@jinso.co.jp>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <f8998234-1ab6-43e7-7dd8-859933b2179f@i2se.com>
Date:   Fri, 10 May 2019 11:05:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557477738-20634-1-git-send-email-na-hoan@jinso.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:wzz1T0bbfVGDOnI6uyGkDlwQzvTlBc78kHbjrTErqfmah+moxCd
 vlyjYfixKCsd+ywYhyWUMyYva7UUEpup8FOoOuoGTYNT3Z3EsEfwD4TQK6Yb2ZtcK952IzM
 nWNyE92iEe37jLT5EKuFg1QpTbn5QgtqGNVkirsLGSN2SQQq2MK57+n7j116/IWqdu9wr4o
 Wxv5D2+uijxyoofdgVU1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kl9xCEh4dW0=:tHnGIO023NmvYtXeYYB4nT
 nPihdVL8jd+/geLMaqrreM/4/59icJPaU4SQfFpkiwoUPYa1hWeyzvj0eC4t58YRCmE9FunlT
 KZLOuBhv3jfIyYhPkeuhqWFX7PUermsfEeMjV4wqQhHWBXjlrDFaqguUMf5XUGHSsX3VdzuYD
 t+LVtg/dzhYi1eCfrzzPMHRZOgmMVB5sm35N/wi4ME/Bk3mhcge0ZhDMH+T4HaPBkMjnkoGca
 5I2bjkRDBNv6nskX2amF9P5U08bjS5FTga02nO70owZ2D/bu4j2jIKT5MWjFVakuiIBjWpWUA
 K/ZdqyrhGL1k8ThckI5fsNEcrNL5fS8WjzmtGr58j/blszho0DLOs2YFKrQnNagNnq+dViwed
 0WSC/aRPr0sMCygfWDVOqRFC2pGk1spzuZc3DukpHN3wWJisIsdS6nwxiPWL8kJpk5pLJ5/Yj
 2EMD6/k0lktgEUBU3t0hBGV3+i3TvKfppCOzd530KeWMXeIZIzJKPyKbTR2FQ+br3L3ErXZ5A
 34mDIq5snP4ylDIBBWh00d+0778hV++Ojlj+kSCs1V1wG6sCUEaY9MQsoOFU3GfGWPrc7mxF3
 bMvkexUD0+fTJBrtRhqkYJpLn6rJsDPQBOS5Tbp3xkL0TghJAjlsRyFdBo9XLZXUNMmt2sXfn
 sB8yYZef9sVGBMs3gaSc4/ScL3RreugxU39UQ264liUQfwL7HMC9osPYXumlnsxSWyMLCKtAP
 UkJyDZoUr7ARP/na54lp/pBIDmPm/2VJOA6dU2A+L+BF/lRJtjpR8yX5VAE=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 10.05.19 10:42, Nguyen An Hoan wrote:
> From: Hoan Nguyen An <na-hoan@jinso.co.jp>
>
> Printing an error on memory allocation failure is unnecessary,
> as the memory allocation core code already takes care of that.
>
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

looks like more spi drivers are affected.

Could you please take care at least of spi-bcm2835aux ?

Stefan

