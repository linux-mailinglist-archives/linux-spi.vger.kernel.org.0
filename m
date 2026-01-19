Return-Path: <linux-spi+bounces-12500-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8BED3B71B
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 20:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18CA830006E0
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 19:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA91DF987;
	Mon, 19 Jan 2026 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="St5EEMdw"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A249750095A;
	Mon, 19 Jan 2026 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768850283; cv=fail; b=HAFLBiyY3vVoHuRiLQ5mFc2KKtzE8FQHVM/MpR8yZ8fmqJr2GfJZRzVvFxIZOu6yO/TNwZlYQUFC3PfjFqs4Po0aQV/MprMhLTsAX46m5/rDH+HKhDQQ46BIgj/2eo0T0lyxYBhmonlpHZhyJxDEAtOEJafO3jFO769FJEDYuqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768850283; c=relaxed/simple;
	bh=XAiJKQAs2cO/LbcuGRn7l+TRxBEbnn5EFiahv3IJ3ig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AEKWFUWEcaYrmID1YjHcU9en9gn/BcyavCkpMleBjgyUMQOSaupyGON5MJhpXcf8JbYor6G+24yKEwjWkiQa0wKHUVYzVjOdAJyUjGv0mGjmOnvu9bOyOcrYxFbO+ZOWXo7IvxIL2efiZamrPeaK+zlFesd6Jf5HnBbSw1YLHWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=St5EEMdw; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9TcaggFBSOzW7VnV8GH01XVPRTBgWV4FUmzoN2ydutMGpGslb5FeIAH074pInl92/DDmhTY4l1gRVkMfBtC6lh9vWIrX76+029Kf+nyIPMVJRKroFDnlH0NtrNzuN5sWlgJOdtCT5UTdPcdlQzQv74nJ3rszT+Ndy/8QSuUfGLU8Pzl9rBR7UqcgkeyeFUeVW7ux4VGDfJT0YX4/3eJjPLWytk8QtYfPY5tsAdrH88gGyma7Roqxt+zFYqT1Qok3NWNKKD3w06oDrlDiKIWeRb1fWxe2BQWWNDYBE1P1zaPqKBtLAjWUJ/vmmENc5lqBhs5FkH3eLBGwVuTnowesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rKFcIEPGntINjL7uAe1Gqf6965+AgHpzuEnXgk/qFk=;
 b=bsuPc3yiwnZrAKrXw9uCBWlEDZDwHTgXPyxPtFtV0zhSFBY7jsS12ZFP3XdC67ZPqAx06EdoJRWI00pF9OlWtE8WG1WttEGElDoQ9w6cWuDPGEtl5fOBnnWMondareMDxbJ9ROfyrDXud5VI1H/PzyuMyAjjM8mw1L9VuMG8urR2zb1su7Z0UEl8BAYdv793j7NqtWsSHD8t2DOq2rk7ZlGqyDQYg10MttLUgpahYkB6Yqb7eTzYEr7Z8RbcOCIp8EQrqRyJcsQAKZVbuwU81F9gue1uNNtHkEr1XOtfrpD4HUXW6ndQp23Paw6u3sTDCPZenetQ/lWHdpgCs8MUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rKFcIEPGntINjL7uAe1Gqf6965+AgHpzuEnXgk/qFk=;
 b=St5EEMdwkuVtSBRG+yTZH/mpXwJgbH9aewTC82ajUieCZD0lOTwzFwzg6BVGKfTPcbyuc93QZ7CLsTVC8khzIEs1kZAmTF4h5w5fbOYdqvPbNuPDZnu/CS9zW0fEalVwpZpKwPOHHLJmIl2mrShZPuROdWgTI9yuH0oujx2KpNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 19:17:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 19:17:58 +0000
Message-ID: <a3fcef3a-d1e9-4b46-b114-3a82575e052e@amd.com>
Date: Mon, 19 Jan 2026 20:17:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
To: Mark Brown <broonie@kernel.org>
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
 <8436e914-429f-40b9-8e6f-ec3b02702cad@sirena.org.uk>
 <69F83558-4675-4FC2-8656-BC6E3481AD65@nexthop.ai>
 <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
 <05D2CC15-DD6B-40F0-BFF0-3264D4FF96ED@nexthop.ai>
 <b1b79de0-a078-486d-b3e9-96899354407c@sirena.org.uk>
 <3D1B59A7-6E57-4C8C-AA95-EA7AA115264F@nexthop.ai>
 <b9ad8ab8-7985-4c89-a82b-c7f31d32c167@sirena.org.uk>
 <a6d57890-89c1-445e-836c-d8239d20c621@amd.com>
 <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0004.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::11) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: d528aab0-343e-41b8-99d5-08de578f74a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmZWUXFFdWx4dkRLTTRLT3krTE9xYTl4MXEzTWNkQjlYb0VkZDJDYnozY3dH?=
 =?utf-8?B?MDRKTEplNFV2dGdZOHhhaVF1UkpCWDFQTmZHU1ZmRzRUWm5XNndEMDh0MW9J?=
 =?utf-8?B?OEtObS9WL2pGYXRsaVRyeEpBbURFam9VMjZ6bWd1blNkMUtxOTY2VkVBTGNU?=
 =?utf-8?B?VWpYSjcyRlV5cy9jdy8wK1lyOWdHaExvbFpwbS9Wc1VwUHdwR2ZqelY4aTJ2?=
 =?utf-8?B?eGZtUGVaNnNrYnExQ3pyVlVBY09nL3YrOVJZK2h2dzRTVFVoNUMzOVMzYmND?=
 =?utf-8?B?OXVrcWx0azh6RU4zYSszdThFRG1ja2M3ODYrK05xSnZHKzZuQTFGemtNM3pa?=
 =?utf-8?B?NVhEWnBsUDlRblRPZWdjSkZJVnlZTWFLVnkxTk5ZUTVSNXZDWG14UXZuL1Zh?=
 =?utf-8?B?WktDM25tV2dzL2QrR0RCWkJYVXJPOVU3dDkzeFJXTWxraWlBNWhQcmZ6bWUw?=
 =?utf-8?B?U3R4RERKMFJTRWQ1WGxrT0R1WG44VUhrTjBKd2ZvVUhlSVoxeHk1akdYT3NY?=
 =?utf-8?B?bm82OStJN3dWT29hb2s1RnpwbVJDT29jSTh6dkp6WWFxeTRmYS9sVExvNnNS?=
 =?utf-8?B?UkUxL3dMdXhPUmtQRTZTM29ubmxyOExna2ErajlDUFRia3pzallLckZDUFk3?=
 =?utf-8?B?eUl3SnBFRmJ0aW54ZE51Y00wOTYvcDF3MVdXTFdqZ1NINzVlMjJOd1h2Zlgx?=
 =?utf-8?B?UURweTZhaDFqdmxsRzNiMWdGYkhFVHZ6YXhnN0xkaDA3cGJsMUdoWE5wYmU5?=
 =?utf-8?B?SDBNSVM4R1YzdXhNSkZaeXRCK1lIQ090Y1lTY3d5T0RPM0xNSDh4b3JIVU9x?=
 =?utf-8?B?aFpiR1Nta2hNUGFaMTdxbFBUYVMzU3VON0R5bEdraU5jb1BmcFEvaWo3Q2l1?=
 =?utf-8?B?ZytFMzFTMkh6RUJZaFB0NlByLyt6UjFXUWZxY0lXRnYwVlFzQUFZYWdHa2lu?=
 =?utf-8?B?a0VycFZqeE9mSnBZRWtURVdleHBwcEFKVkhXY2pGQWU3YjdRQUtpWG1QMUNY?=
 =?utf-8?B?M1hMZGhmQzlmVXZFSDFxSDNKUVNmRzBzd05qdWFiWm8yZWlUcDlnbzJwZUEy?=
 =?utf-8?B?ck4xVkEvV28wbkVNUExnd0Erem84eW51OHVsb0xONVBURTlzdTY2MGFKcnR0?=
 =?utf-8?B?NTluQW1CNzlrdDVKdGdZQ25mY1htRlhHb3pSRFFvRnE5ckwrVTFpQmllelJX?=
 =?utf-8?B?WlhCaXF2WW90ZTBHc05XNTQ2T3VMSlFCeC9pVlRmTGtSN3RIeS9KT0N0NStx?=
 =?utf-8?B?bU5NRUdiUTJ6clpRT2VzQzJ5bG42UmpDYURtQkJia0NnSTRoSWl6bWZEVHNN?=
 =?utf-8?B?dldONlE2T09TbUloV1N1ZnhyMFNQbS9LUkVXNjAvWWxTMERjQ1ozMG4xYUl2?=
 =?utf-8?B?ZlFZK2dYZnd4Q2w0djNMc3o5WWpOVFNaalduSldROGZjNHlJK2Z3SVhHV05n?=
 =?utf-8?B?Q2tNSkhQUWMyNThPTUFMNjljZ2dvd1FSbFM4SmR6NFJtTVJwOUtwMXJLb2ov?=
 =?utf-8?B?aEd2djh0dDRFV09HWGNnbGpVNUlkelFqZzFTZFBvV2pyNFQ0ZXkrVTVlY3pn?=
 =?utf-8?B?Tldpc0hyZmRMNlVWNkRycDhsUCtIbExlRHZhN3VsY0lNckNCbVJBSWcxc3JB?=
 =?utf-8?B?SWlxcnRVTHdMVmZJMzZ3SzBQV3JIR012NU1CQ0I0dGFOUkljRmpFN0lpWGZB?=
 =?utf-8?B?TlQzMTEwK0tVdlVJM3kwZW1JT1JwZENQaWRBSzJtRHowbnpqbERHdFN2VTh4?=
 =?utf-8?B?SE9YK1llYWs3K2xiMSt2U3Bqa3NVOVBxeHE5ZVVERnNqdThudzdETWxoRFZl?=
 =?utf-8?B?VTh2cXBJRjhsWFA3eDBMMVdkZDY5Wkx1VDI2Ym5HM3FWVTNzRTVxZVBLMUFv?=
 =?utf-8?B?SktVQm9CUHh1K3F0NlN0eFN4SklPMHFVOEdlcmYxL0NEZ2FiY2FKa2Z2MWRs?=
 =?utf-8?B?YTlpcVlIaUIwdEo4clpSYitxc2lBMVBybFZDS0UvZmxNamJnZVZLVmpleTJw?=
 =?utf-8?B?blhMek85VW1rL2JEaWdyMHhPL1lzb1JxUHQ5Szh1eFU4eUNsT1p6c25VZUcz?=
 =?utf-8?B?K3c5djRKdWJLUWx4V2ZDYjhhd2V5eXFYZUloZUVpNlplWWp4Qm5hblY3RVNo?=
 =?utf-8?Q?xqIw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnBQODZpeXNZcWxjMjVLUFc0alEyUk1PVm9sMDJwTmNlUXl5UkVmTnBNQ3lq?=
 =?utf-8?B?WWxhQUFnM25lV28yTXpQbGcwb2tjdW12eUtvL0EyRzduNytJaVZlQU5URUNF?=
 =?utf-8?B?TGNCTm1wdk9FYzF3Zm1RN3g0RURzdDhyYjRRVzNxSm8xOTdMcmNLQXl0aGRW?=
 =?utf-8?B?MFdWTzZ5R2FuSGs4TmRwU0pBWENhLzRYajlOc1hLT1A3OUJSVWUxcEVScm93?=
 =?utf-8?B?aVZ6K1huUkljNExnUXB2bXhQSUZ1RWdkaC9taEpPYnZraXY2NU5uYWNOMndh?=
 =?utf-8?B?L3lybU9xSU8vcWVQaS9hdC9YWWlJT2FRL01wbmxUMWl5ZUJ2WTlkZ2c5bm0y?=
 =?utf-8?B?N25PVmtVd3p6Zm12bCtjY0IxbjdJbzQ3aXZGT1FNSzlvbVlpRnJlZTdtenpu?=
 =?utf-8?B?dVB4ZGdKVEdrS3ZsSGk4TDM2VnBXL3N5QzFlZVMrR21oWkJ4d2lEQ2IrQm9s?=
 =?utf-8?B?SE44Q1IzVUh2cDArRWpOZHBDRmsybDZsRHd3TEx5RDVTZzVxZWhzMmIxRVhP?=
 =?utf-8?B?Y0tEc2p1bVRPSUlEVXlHQjM1UW42MkJWbkVJa2pBcGV4bk1rZnhBTUZCdXhS?=
 =?utf-8?B?OEhzdmhOZ05oQnorcVhZUXR1VTQvUGtUQ1RJSWx3OGF5dDN3VDRzcG9JWEM1?=
 =?utf-8?B?ZXdQVzRHTTNEdEF0K3NDOGJFM084NkI2bEdOclFxZTFIdDdEYUplU1R1bU5v?=
 =?utf-8?B?UlByMHpUdGtQOTNjNFV4cFRveVNWbXRqRlBnemRvNW1adHBDMjdNMG9xTTB4?=
 =?utf-8?B?WGdSc1pXU01DWFN5MjVLNFFyNDVWcUQvSW9WNzV3SldqZU9vVUV3eDJuM3l5?=
 =?utf-8?B?M1YrcVdnSy9mc0dLT2M4VFlnK1lES2N6eUZpelMydnFPWUQvdGpSS3BVWHBp?=
 =?utf-8?B?ekR4SjEvRUs5dytxbHovOWMyZ2dxSlhMSTRtV1VOYWs0VEE3L3cycEZVNVBa?=
 =?utf-8?B?K0pBemRCd3ZDV3hRT0ttU21Rc2FqTGN3Uk84N1FRZ2JxWVg5WDJrbTlZaHE3?=
 =?utf-8?B?THY4YlBrcmlwWFJ0N2llQ0habUtXSi9OeUpmaG9vblA5Z3RZbERiU3Bmd1dB?=
 =?utf-8?B?bGxYRUdTYmVQeWh3YjhZNi9aTXpWU0JFTlFaRDRoT1VWTzlpcFkrdEYzK1FF?=
 =?utf-8?B?NUdHVFBYR2M4MVJUeDRPQ0dyNWNjS29iVG95cW5WNUhIN054WWg0dm1mUERz?=
 =?utf-8?B?c1pHN242ZUhDWlEwYkFRSWlXUGs2UUJjRlhqTGh1Wm1oZlZOL3l4ck83UGhC?=
 =?utf-8?B?a2Y2eUxKT1BjOGxMZUN2SkdJVlVwV1hvQ1lGUnc5dU5xZWM0M3llNmVjak5H?=
 =?utf-8?B?czhjSUMrTlU1T1duSnFZaDJGSERQVHN0aHp6a3lRRWE0OGxuRytZbWFqVTM5?=
 =?utf-8?B?SG13cHIrR1BYVVY3dUowc2Y2ZmFBZDliLzBzSkh0Nmx0UVNISnR6c1BteHhi?=
 =?utf-8?B?bXJ6Z0NhWEFkQ0pHZFg0OFFNTjNwZ2lhcUJ1ekdRR3VLMS9XOUNsWDcrVTJt?=
 =?utf-8?B?ZUtuSWNUcTZMZVpvZytrR29kMUpnaUZPclgzT3Vja2FzMHlScDNwdllKVWd2?=
 =?utf-8?B?RElSSzdXYzF2N0MvZ0p1NldwWm8zS3RWR28zaDBwSE1nMWFsZjlKQ0l3M0lZ?=
 =?utf-8?B?UXV4eVhsZUY2ZFFuOFhyeGRrZmdjTjJKeWYyNHQzTmtONWZTdkhqdUN1SllQ?=
 =?utf-8?B?VTZiNURCakdYdjk4Y0NDc3dySFliRG93bXNCcUdPakVVQjZqNXkzUHRmelo1?=
 =?utf-8?B?KzdsaXBPRUVFRmkzUmZYZkV6K0FiajJzLzJLT0xGaXZSekp0WXM5ZHdwQ21C?=
 =?utf-8?B?RzFuODRHMFdEWERtd1haZVVrQ29EbjIrYThVUDgrZDVKQ2djRExtYlBJZzVW?=
 =?utf-8?B?aFAvL0hiNm84dTc3RlV1Q3k4UTF2OWhRZjFRTUl3Y0RFUitUOE1TMzZiWlk1?=
 =?utf-8?B?NnQzeUpTRzRTYm5FbnNCenJycFpyTUViWFBCenoxUWkrQ0FpYWtIMXJaNkFT?=
 =?utf-8?B?SE9kbUsrbGhBWks0SDAxNlRib1lEWnJHR1JWMmFoYmk2cUJxOVA0OEg5bnF6?=
 =?utf-8?B?bHhIZWdzZWY5T0RUbzVkNzRqYkVjNU9FQ243MllJaTBCbDRpbzBOc2hzVGRo?=
 =?utf-8?B?VXg5Mm9ZZ3F4KzMzQ1RJY01nUWd2Rkl5MXhTT2JBdUFQZHp1ZkYrWnFOY1VZ?=
 =?utf-8?B?dVVzV0RoQ0xKY1JpZzc3RWRCVnhzR0xTcVp5Q2diT0U4eUFSNVBQd2hMRS9w?=
 =?utf-8?B?YUFEUUNOZ0FJNHhHRmoyOEYwSHA4RThzS0wvMFljbDB3akRkNWZWbmtoZ3Bh?=
 =?utf-8?B?dW5zQTAvWWpmaG9PM2crdUxpWDIzTXVrS1BuV1dPNVBJU293VmtCZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d528aab0-343e-41b8-99d5-08de578f74a6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 19:17:58.4695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZmcgvS4/HqlIQXhwqOSgq6If0VNEQgvh+wP4tJg7wDAZV2nTReeNywU9WTsRApX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854



On 1/19/26 20:01, Mark Brown wrote:
> On Mon, Jan 19, 2026 at 07:52:35PM +0100, Michal Simek wrote:
>> On 1/19/26 19:38, Mark Brown wrote:
> 
>>> This was specifically targetted at some embedded x86 systems where there
>>> was a goal to reuse device tree bindings for things that just can't be
>>> expressed well in ACPI.  _DSD is generally considered tasteless for more
>>> server style systems, AIUI the general approach preferred by ACPI
>>> forward OSs is to use some combination of DMI quirking and registering
>>> with a per-device ID (like the per generation fake PCI IDs that Intel
>>> uses for all IPs on their SoCs).  Just blindly accepting _DSD can end up
>>> with something that's not used because it's not what the ecosystem
>>> wants.
> 
>> Is it a better way to use auxiliary bus as was recommended by Greg in past
>> on drivers/misc/keba/cp500.c review?
>> https://lore.kernel.org/linux-i2c/2024060203-impeding-curing-e6cd@gregkh/
> 
> The driver there appears to be doing runtime enumeration based on some
> EEPROMs on the system and creating platform devices based on what it
> finds there so it's a bit of a different thing, the aux bus suggestion
> is about what the code that does with the data it got from the EEPROM.
> This patch is for something described directly by firmware so there's no
> way we'd create an aux device, that's purely in kernel.

I don't thing it is actually eeprom because in fpga you can place at certain 
location just memory (or RO memory) to describe what it is inside.
There is also pcie config space which could be used.

Another approach would be to just put record uuid and via firmware interface 
asks for firmware blob which describes different configurations.

Above part is how to find out what is where.

If you know it I think you have multiple options how to wire existing drivers.

1. ACPI - which is what this series is trying to do
2. DT - on x86 not sure if feasible
3. platform drivers - as described above by Greg not an option on PCIe
4. aux bus - for example keba drivers
5. dfl - drivers/fpga/dfl* - used for accelerators.

Pretty much all current Xilinx drivers for soft IPs (spi, i2c, uarts, watchdogs, 
etc) are platform drivers (more OF drivers because platform data are mostly not 
used).

It means I think would be good to get any recommendation which way to go.


> I have no idea what the hardware this series targets is (other than that
> it's using a FPGA) or if there's even a motivation for the change other
> than code inspection.

I think all these cases are very similar. You have x86 with pcie root port which 
is connected directly (or via pcie slot) to fpga. In fpga you have pcie endpoint 
HW which connects other IPs sitting on AXI.

Thanks,
Michal






