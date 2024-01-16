Return-Path: <linux-spi+bounces-485-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE7A82F51E
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 20:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CDD1C23A6A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 19:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9BE1CF9A;
	Tue, 16 Jan 2024 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8NiL+NT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04E1D53D;
	Tue, 16 Jan 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432454; cv=none; b=daYknJyVs9MWszOSU/btxOgOXOHZgoSPoW8nbXPk3zlNt+GijzyyOM0QKIdVmBiUQs2U40zR9OFcH0wLLa2Gp4YW6R34mmCOFcsck8OoFcoMzK057GiDnjqoy0dLCTw4ci+qt8M92qbyG1mgA7Z/Gfkiljm2aZApYBI636iQQyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432454; c=relaxed/simple;
	bh=tpKwCnXNKmaoVKMv2ghf5TOzEvyS4zSCPF+Zx2qFG+w=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=UkO0FSdCr0t2BEQS2UUjeGyjVtMDOAXOsDX+BetczUMjKXqniTjcvnaO2vpQ8ThoBdzItFpK4c770o0d+hP8h34wY1YxuARbJQoO/mq4LHl1lH3bmwx+9j+xBS19ZD3jkEPmVQJ8MyYJsxZIiBDh3uh7hyWpbSM//DcT2FwTkTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8NiL+NT; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso4643251a12.2;
        Tue, 16 Jan 2024 11:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705432452; x=1706037252; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MZLUPKoMm7HGGewJ4tUOegf+TEvT6KwpecvPa7fqCl8=;
        b=T8NiL+NT7rQ8tOidQn8pOdUF4DoVNB02+GEoYAhozmRiq396qORSdTFMDHffI9QIAw
         TgpbZkWDd0TrcPHy/tE3wy2xJVQ3Et1aiP9yRM31B95bc5phvL+eBom/wOPQgfZm/aT1
         den1bpimK+hEwLIKgqHqHFN8DQf8X9fURZZdqbyPBjgBDHlXn0mEQCwltDxF3abUvVEd
         szQ9aBOeXp8OOmYjVAX+QukE7eKAtiWCiCuIiAzeNrxXwVGElJ2Y1qbMA9Ns3wdoUz6L
         CeOpwB9BtgvAHXDfcPnGqlY6HRZIGC4f+z6JUi6rKH/eVbhtrUrrqJkWGLU1/eWqV9yV
         M8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705432452; x=1706037252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZLUPKoMm7HGGewJ4tUOegf+TEvT6KwpecvPa7fqCl8=;
        b=BjGzq4mK2ZLMMcaj8yDAZUYynAz6UFRzzraznrkXZEs7LPt/w6GzjRBvXIYv1348PS
         3BBxLoamSsqIXUiYpGzwBW4cpCoVvR8zx+RlKzGRl1SuSYXS+IvWjO8NZVVy1XpBUzes
         I6EZv5t9lNuHpqbMvQ9vR5Xp3TkzqnLKDC7BE223CfgGAiKmcUC1HW0eaqrrQsVClZDH
         0P3WKPeb1QULfCzeqXBRZV0VMuFra9JWUz/0ve+CJefbm9ccq9y6FNPK9Nrc862d4y8J
         WNZWWDMYEkLHiSNny0LapR68+qBd6O3qW7JomBWwEvPI6Luh71UvGd+hKWnl9a6Q3WfT
         AAwQ==
X-Gm-Message-State: AOJu0YxJ8Lze3+TM1/sxI54xZ3CNF1EznxdFbzbJ1KCp6pfbqdpKCNW0
	r25d/oj9Hzyaj0vpgcRwkxI=
X-Google-Smtp-Source: AGHT+IGYbSYmjB24NTQxmaJssKIY6tVcZ8Ft9p73NKEtBQlF+QNlGUOpdtE5extmmvz6qj40BAO7QQ==
X-Received: by 2002:a17:903:1c1:b0:1d5:e4b0:b27f with SMTP id e1-20020a17090301c100b001d5e4b0b27fmr1319464plh.52.1705432452126;
        Tue, 16 Jan 2024 11:14:12 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5c15:9a6:f612:d37a])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902dcc500b001d6e8f28f71sm241923pll.159.2024.01.16.11.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:14:11 -0800 (PST)
Date: Tue, 16 Jan 2024 11:14:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-spi@vger.kernel.org, kernel@pengutronix.de,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 04/33] Input: pxspad - follow renaming of SPI "master" to
 "controller"
Message-ID: <ZabVgZRjcpMKsw8z@google.com>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <5e05e8f918ba1f026b9967b0aaff5403a35cbf13.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e05e8f918ba1f026b9967b0aaff5403a35cbf13.1705348269.git.u.kleine-koenig@pengutronix.de>

On Mon, Jan 15, 2024 at 09:12:50PM +0100, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with the rest of the series.

Thanks.

-- 
Dmitry

