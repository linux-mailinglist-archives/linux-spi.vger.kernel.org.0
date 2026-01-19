Return-Path: <linux-spi+bounces-12498-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D84D3B638
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 19:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35FB130223F2
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 18:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F87838F22C;
	Mon, 19 Jan 2026 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u5pELx8Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDDF38B7AF;
	Mon, 19 Jan 2026 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848773; cv=fail; b=aH6zFitjpJZ7V9WRZR/lo29pyMUFh/N34jhLsBaOEmPtoG1/kLZw3RH+MWaKZLW+FQA9pYIqlF63rSIT88S0pwNeGwSwVA9zFTBocdk/j2GtQwEpuOSM/5rPDl3mpSDRf7I7WMIrtk6/wk69kArc5dDHjb2d552xjbrkQlyCGt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848773; c=relaxed/simple;
	bh=8dvcRYYDnSaW3MS+mMgU8l8thVNV8uiDLgBd6RDj/MY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iz270kXnZ5wkE3+6PYwu3V6Gj3C8Af8T+mYoFmo6ZB0cEEWi9fBZFdpPPjR7Qwl/Hy0L9995IrMu6t6R4BqqtFsi2wc5yFNgpCke3agq1eyp1Ns/SmGuUBJN4ngDEJd3y/b2M5xnSlQV3W1/MSBNAIg7+i0g+O1EeWCrfGbpUCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u5pELx8Y; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beVWDXeUaAAECbVLk+YFLOC0nxRrb+vlcvf/RamVveacjQDCQlg44zPc77JYhsooSz4uw6X4fsxI+Qo9vtjTgT5gkStSHXkqACbQ/hPhgyZPcS/Wgh5wIYb/9d8vqdTDhbpeHLKHFZi9d1btoGRYB/XsDKmOpGo3NN4FtnVPfaVmSS6lGM2vz9IYRO4fLblEOI1nHpFxT+zU3c0NqkOVhoTq0fhsWQ64p7bY4kEUYIVwTO40STtvvkfSs3EouJJT82pz4N8QeXFX2/FxutG3AJzq3uDOiPWzS5Tb6PUnZBeTXli6jIkMO1gpKnn6AuNWelEQm8/Un+PuTBTwlUyMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlqLs8aezssDC5LIDkTHe/uKSOvW2+B11YtSVO5O7iY=;
 b=ZgQa94u+egLMeoP699vaxu009W73sFl7/MEx1bdlVrfLo9O47Ph6Nw9G6UdmurxCRhuMlT2a2z+XJP+/Q6H3aAC9xI/NPy5z52kA5/7wM5VcopBNqhCzNTOGoaiQiNMmLfDJ5nB+cmvs4+dtUfY60+sZH0EpWdQA+OlPsswLBDw192RxO4EMqzJ+ZXl5TOUJVm7y9EndpZ/TEfzkG9VkucSjNk3t5k6CWFMl2MvezhDFVVPwuYo/LqQMRaYmkA3aE9lmwmqKFfvb39tEIPazZz07Kn4sEI9377dzZ0zS5rAu2RBothYqEmyHd+X+mdDtGR1kiNJ6t530X/pO1r4Imw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlqLs8aezssDC5LIDkTHe/uKSOvW2+B11YtSVO5O7iY=;
 b=u5pELx8YYoiJrb4s6eUkFZ0af19bciu8S5KTictP6FWF3XT+jf6u3CMqRmQ/ZgkVarjBLTjoEuQKZUej8hZsNBYWqhSkcjE9Ix/3KRKVN8kJkEPAiSJuDXNulX/hMJS/WtS8iD1r2bQp6DARDLfF86B94xz1pIKJOrpRno/hxmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 18:52:49 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 18:52:47 +0000
Message-ID: <a6d57890-89c1-445e-836c-d8239d20c621@amd.com>
Date: Mon, 19 Jan 2026 19:52:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
To: Mark Brown <broonie@kernel.org>,
 Abdurrahman Hussain <abdurrahman@nexthop.ai>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
In-Reply-To: <b9ad8ab8-7985-4c89-a82b-c7f31d32c167@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0032.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: e62c7657-3ffa-43e3-84d4-08de578bf028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUlOMDE1NXRCOFA2WkFzcStXZTdSNmlEaFdsKzRKYkx2RURSZ0tic09NY2hv?=
 =?utf-8?B?dlVZSlJPN2tTOXFkenFGZHJac2R4M28xdFZxTmdsckgwTzFjRmdNQ0NvR2tm?=
 =?utf-8?B?ZDcyQi9YMSticVJudDh2b2ZZVDdDVGoxeWxnVWkxcWdwdE9GaVVMUUp2T1d0?=
 =?utf-8?B?a3JoUFNKczFXVkVqdXo1bEFQREtvNmNlZ0czdVB2YktVbklma3pqKzZYdlNE?=
 =?utf-8?B?eFdEMWs4YzI5Y2NtWW9FRTZDdGhZOWFXM1B2OXpUZm1TZ0x6RXI5bE56TlhF?=
 =?utf-8?B?OFpmbFdUM01UeDBDcjQxOTlUS2tOUlVraTJGY08rdGl6bU1xUlkxcjc4ZkEz?=
 =?utf-8?B?cTBrMWEwekJoS3crKzh1cnR5enZmSTk3eUZUOUF5dE5aU1RMTjZEcHVrVHgr?=
 =?utf-8?B?VVhYTEdUNHo4RFdreUVTRWR0Y0JNbklQcmt6ejFwOHZYU2ZDZlVEblY1MmJT?=
 =?utf-8?B?bml6ZDNOSDI1dllabkt3UGJ3QU9MOUcrNG5VOWpoaHlLWDNQUzFic3pBZzBK?=
 =?utf-8?B?aEJPeEZkYVhaWkppWFFrejNva20yOFk0UDJvTERWNUhQUlVQbzJpeVdyOUow?=
 =?utf-8?B?Z2RKR1Zudnh6RlJlSlk0UmxSdVRQUWFBOXVHS2FRTGtYR21OSGxkTmhMYVFo?=
 =?utf-8?B?NytFTFFCcWJURm4vL2IyNElqcXlvaHV5ODVHZndnaDg0bmdHZ29xSmZsN0hU?=
 =?utf-8?B?dmJnay83NUhveFdnL0trLzE0RzlUcFJjNXAvTmlmazBuNmxKVCtBWDNtbWt6?=
 =?utf-8?B?enFzQmszOGxheU8xQUdzWFJMSGsxQy9TVkRSUFZGRTR0eXpKSDl3ZzRvMHlu?=
 =?utf-8?B?RXNuVlpCakhPMllsNWlOZVkrMlFFS1VGSEtsd1dVSDZycjJ4Qm03SzRjZzZ6?=
 =?utf-8?B?ais1aXNSU1JVbVdVallROEhwbVpMUW94RHFtdm9jVThRTEZYaFhBRWpzVHVE?=
 =?utf-8?B?R214UnVmYURsUUQ2d2I0Q1JDU3JlenM0VWhneEFBZmdXTTl5RmpLemlBMFJG?=
 =?utf-8?B?ekxQU2o0QTJiSDhYMzBxVzVzSkdNUTFXQWpvWFF0VlZJMjBsd0dFOG1aM1c5?=
 =?utf-8?B?UFkybVdIb2hiZVNucGZ0NHdsOUNmMFljS2tPVElmVW84VktzOTY5NGhRTVVl?=
 =?utf-8?B?ZFRjR3IzdmJ3SmxIb0NHZHpEcDB1Uk4yak1tWWxObytNZi9oZExYZ2U0Nm5l?=
 =?utf-8?B?MEI5T3RoZDRzL25SaEVIaDlvRUx2ZituV2lDMG84NEtZSWdLNkxTYkxyL1d4?=
 =?utf-8?B?ODdDWUsyM292ZG56M2c2aGp2Zkc1dlpmL0E1LzF1SGdvbjg0cDdPVmtiU3Ri?=
 =?utf-8?B?MUo2MHNGK1BvR0FUZ3dRYzVQODRNL1hyakVsdXFIdXdvN3B4RzJ6UjZQWTJL?=
 =?utf-8?B?NXVaY2g0MDdIOE10VDYyU01PVGt2RnMzc2tNODEySWZSWHcwWnJXMUhESVU0?=
 =?utf-8?B?UGJNQ0g4Zzkrdk0yaStzZ3VjL0o0V1NzaXV3U2VKUE9hOCs5VWVXeHBJVExI?=
 =?utf-8?B?TFBDa3c4THZaQW54bXUyZUtoeFExY1Jxa1hUK1YyK2F1ZVNscThTQzNoRHZ2?=
 =?utf-8?B?NGxhclY4ZytETDFFaU1nQTdld2d0WUJ0RDEvTEtWNVNPTzNqUnA3Y0x0Rmsx?=
 =?utf-8?B?dEVyQmtZb0FvWE9UbjlPYkZVM0pMeXhvaW51dFl1WU5uTyt4bWR4a2VMaTl5?=
 =?utf-8?B?VVN1ek1GZitVZUI5SkU3WjFQaUtOWjhvaUtRSWh3RC8yZzI2eFRHZ1pjQVlh?=
 =?utf-8?B?c0xoeFNrNW5iN05qcXpOb3E2aHl1T2EvZ0tDdHdJQmV1R3VMdWYwQnpHSWRw?=
 =?utf-8?B?YThRMGdlbWtuVTJBQmVnaGowN05LQ3R2YTdmYXduUFJLWlpDK2Z2U2lIeFNr?=
 =?utf-8?B?c1ZnQjhLS0RwN3BnWjlveGpkQ0RTeGRleCtsTnNuTW51WUhZajB0SGdzck9s?=
 =?utf-8?B?VEQ4NytsajJVSVN6OGhtcmZjc3RNZUx2OWVxN29NdjYwU1FLVGhMZVBsMm5y?=
 =?utf-8?B?blZxR0FyZ3YvT2dUcUszZHFRQzVsNmdzWjg5Rzh5T0NGS21WZFRTK3NMaE50?=
 =?utf-8?B?Zm5FaUt3OUxnVjVBZG9iSFc1Y0V4aTZqcEc2b0h1c05JTTBMKys5bjVWUzNP?=
 =?utf-8?Q?QLWs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDUzNWtrNWtyRG5MajMwbkxJQWR2R3JOakJxVm93UmhyQlkwUkFBcDA0NXFT?=
 =?utf-8?B?aG5lS0lhK2NpMTlXazZ2NHRjZWQwQnZLSnc5ZjlFV09SUnBDOFlUMlV6RW9Z?=
 =?utf-8?B?c3orTitYK1VwMVY5RXhERyt0NWE0WndMOG5HQ3NZak0vWXFod2Z5ZzlqYytH?=
 =?utf-8?B?UXB0OFBBemJtaTY5UktuczNIQmtSa09KN20rZzhBYzlUVjBXSjNrc2Fsb1g1?=
 =?utf-8?B?cXJtUWtmZVMzTXhuSXNNU21WcmVmSWo5UGpMajVDaGRJdTlEVVNodmVzMjBo?=
 =?utf-8?B?eVVhNGs0UVZwQWNyTFNIZXRMNC9CeHFxeHIxOU9PS0Jlclo2Ky9CQnQ0VUox?=
 =?utf-8?B?aXBqbmQ3TFNVeTBtdGNnSmU1T1dvQytPYklOcWpXZE9USnlyS0RPRE05YVJ5?=
 =?utf-8?B?TUhIaW4yc0xYcE9oSUJ3bWJMK3h1ZjQ2aStNWEZFZll1ck13U0Qybm16UFRu?=
 =?utf-8?B?WjN3RU82eW0ydTZtZHNOMFVDbGkwNHNBSW5ieE1FYlBxZVorTWFyeGVhSUpY?=
 =?utf-8?B?OUVlejVaVGlzREppSzE4eXNnQit0Z2ZscEx4VkxCcE9MMHhtQTk4QVlzUkox?=
 =?utf-8?B?eUlTSnJRck1sYUUyWG1PNndQWEJ3c0VLSHd6TEFBUDdDSm5HUEd5dU5oTGRX?=
 =?utf-8?B?YjRYVjk3MDZaQys2TkM0UWZDeHpRVjd0MG1hTHRmd2RXcFVsMC9OSkNXdzVT?=
 =?utf-8?B?TEVYbGx3Nk03aE5OUkJncnJYOEJ4aG8rREJsVk1QOTZVbnh2QlV4Q01QRmR3?=
 =?utf-8?B?KzdxMVVRZWlRTnBLTHhNVWF1aDBXUGZLdjQwandqQmNtUGFoWnNpZ0JEc3NN?=
 =?utf-8?B?QXdTc3NWMnM3Z1B6YWJQUGdUa29nODNTZVF1RERzVVNJR1ZBV21pcVZMdDh3?=
 =?utf-8?B?NVRabnpXcUlYTGhOdWtyRWZCa2JwRzl4czRkbktnWnhKZzlxYWZ5WXBNU2h4?=
 =?utf-8?B?NERWMEhVbGQ0cUdMWitnaTR6Rmw5TXkxeGpPcmxiRG9UbmRXQmZVb082MWtr?=
 =?utf-8?B?VWsxUno2eVVHY1hrOXc2RituMkhLR3VtWldXb1kyc1BHemFuS1JqRURZVHYz?=
 =?utf-8?B?cmx5UncrZ2l2ZGFoZzFTVXVWbzRxZ09QNWpSK2tMNmViRTdsQVdwTlUxQWxv?=
 =?utf-8?B?MnNpdGtYbzUrMGQ3OEVuUmU3VDd6QjFvU25VaEVnTkV6cVZLazdKUmpyYzMr?=
 =?utf-8?B?MjdPQ25tcjJaR0xSQWVaZ2EybzcyTGJDb05aT1JKbzhrNjl1RW0xWHFYK2Nj?=
 =?utf-8?B?NGdoWWtPcU9icGRyUVFBckhKTU4xZEY4SHNMUjc0d3FST3l2dGdHbmhraGdI?=
 =?utf-8?B?N0hleEc3UlYzaTRRdWdHQnpOelNyWU13eXBYaW9XOFRkTDIxWTZNdGxCTE9E?=
 =?utf-8?B?eEIySDZ1OFgwYUVRVzBka09TbzlDWkY3V0taUzJUaXNBcW50V2pzQTE5VVBk?=
 =?utf-8?B?MStpeUllbk9PajRlNWI0S3QyaEM5WW12SFFHbWNPTVpESGphdmNESXhIS0hP?=
 =?utf-8?B?dXUyTTdLSzB0TGJ5VW84dlJONEMzYkNXbEw2RFBXL082enV2Tkx5Z0REN3J2?=
 =?utf-8?B?cmRobmpobnBCYUM4UERiZ2pYVmtKZjZ5MzhjaTZXRk1raFlUQzN3TUR4TVNq?=
 =?utf-8?B?VG1TY3VYbEc2dU5vVDBjcmExWTRZQXNLR3hoSkVSRnZpdXVIRjRZMFo0d3FV?=
 =?utf-8?B?N2VIbGcwaVk1cmlDTlNGMGVoYjdkK2IyUTR5TXFYWHZHVTZQTlFPa2FoYy9u?=
 =?utf-8?B?bVRRR1lFellNY2w2NGE3Q3FaOUE3TCtKaVZkWHZxN3pheFoyL1JQUEtNbm05?=
 =?utf-8?B?VnRxNWVabmMydFZjNzFadlNISjZIelpDSzdtTTN1TllOUmFxWmJpeFBpMXBq?=
 =?utf-8?B?TXM5eGVDWXhNaHg2dUpwUjlDZW56dCs0SmlDMkRRampwbzVrZDJnbUE3OTNh?=
 =?utf-8?B?bVhEbUdwSFVzK29aeHhhbVJmNEtqdDlzdHM5TjZuQnJKVWVPVjB4d2grWWNE?=
 =?utf-8?B?YW5SZTRXT3I0OXNjVnE3cUxldXdDM0dPMXBHNjVhYVdxSXR6YlJsV2cxSFkz?=
 =?utf-8?B?dG83UGcwd2F3ZkNIOVptb0JpVlE0R1VPeUVhUnNTSVc4VHZLTmtQTmpyZUw1?=
 =?utf-8?B?eEZzajJZL2hTWkFOTXRNWnl6cStwejM2ZzhFYmFUbmNUSDFSd2I0dVhiYzY2?=
 =?utf-8?B?V2pJVUhQc1p1OVlER3FnT3NkUTRNSkx5TVFLOFpKbTJyLzlGK1lCODREc29S?=
 =?utf-8?B?ZDZLZUF2eEZ0a2FOL01KRUtRTXZkZ3ZUUzFLcUh4RU83RFpIWHJCSmlGZm5T?=
 =?utf-8?B?cW50ZDgrRmxUd3VaaUNPOGdaVVRmMmRkZHcxTTJPeCsrbTBwUTNPdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62c7657-3ffa-43e3-84d4-08de578bf028
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:52:47.5259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z67EtOgoWfRxU6lt9CkGzeIcY2ZrQkURPdl0WyuBeyHFGSfnA28ct/K0+AWwHYPJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409



On 1/19/26 19:38, Mark Brown wrote:
> On Mon, Jan 19, 2026 at 09:47:11AM -0800, Abdurrahman Hussain wrote:
>>> On Jan 19, 2026, at 9:32 AM, Mark Brown <broonie@kernel.org> wrote:
> 
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
> 
>>> You are just bindly making the DT properties available as _DSD
>>> properties on ACPI systems, ACPI is a completely different firmware
>>> interface with it's own idioms.  Does this interface make any sense on
>>> ACPI?
> 
>>  From the above link:
> 
>> "The special DT namespace link device ID, PRP0001, provides a means to
>> use the existing DT-compatible device identification in ACPI…"
> 
> ...
> 
>> Is this not appropriate?
> 
> This was specifically targetted at some embedded x86 systems where there
> was a goal to reuse device tree bindings for things that just can't be
> expressed well in ACPI.  _DSD is generally considered tasteless for more
> server style systems, AIUI the general approach preferred by ACPI
> forward OSs is to use some combination of DMI quirking and registering
> with a per-device ID (like the per generation fake PCI IDs that Intel
> uses for all IPs on their SoCs).  Just blindly accepting _DSD can end up
> with something that's not used because it's not what the ecosystem
> wants.

Is it a better way to use auxiliary bus as was recommended by Greg in past on 
drivers/misc/keba/cp500.c review?
https://lore.kernel.org/linux-i2c/2024060203-impeding-curing-e6cd@gregkh/

Thanks,
Michal

